require 'net/http'

VERY_FIRST_MATCH = 240
# 240 is hardcoded match_seq_id of the first match


class FullScanJob < ActiveJob::Base
  include Sidekiq::Worker
  queue_as :full_scan

  def get_json()
    # Scan sequentially from the first
    entry = ScannerStatus.first()
    if entry
      start_at_seq_num = entry.match_seq_num
    end
    if not start_at_seq_num

      ScannerStatus.new(match_seq_num: VERY_FIRST_MATCH).save
      start_at_seq_num = VERY_FIRST_MATCH
      logger.warn 'NO SEQ NUMBER'
    end
    data = DotaLimited.get('IDOTA2Match_570', 'GetMatchHistoryBySequenceNum', 'v001', start_at_match_seq_num: 240)
    if data and data['result'] and data['result']['matches'].count
      count = 0
      data['result']['matches'].each do |match|
        if Match.where(match_id: match['match_id']).count == 0
          count += 1
          s = Redis::Semaphore.new(:add_to_queue)
          s.lock do
            Mqueue.find_or_create_by(match_id: match['match_id']).save
          end
        end
      end
      logger.info "Added #{count} full"
      if data['result']['matches'].last and (last_num = data['result']['matches'].last['match_seq_num'])
          ScannerStatus.first().update(match_seq_num: data['result']['matches'].last['match_seq_num'])
      end
    end
  end

  def perform(*args)
    # We perform full scan only if we are out of matches to process
    if Mqueue.count > 5000
      sleep 60
    else
      get_json
    end
    queue = Sidekiq::Queue.new(:full_scan)
    ([queue.limit.to_i, 5].max - queue.size.to_i).times do
      self.class.perform_later
    end
    logger.info "finished scan #{self.queue_name}"
  end
end
