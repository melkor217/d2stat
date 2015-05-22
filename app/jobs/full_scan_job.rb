require 'net/http'

class FullScanJob < ActiveJob::Base
  include Sidekiq::Worker
  queue_as :full_scan





  def get_json()
    # TODO: relations, multiple workers
    entry = ScannerStatus.first()
    if entry
      start_at_seq_num = entry.match_seq_num
    end
    if not start_at_seq_num
      ScannerStatus.new(match_seq_num: 240).save
      start_at_seq_num = 240
      logger.error 'NO SEQ NUMBER'
    end
    data = SteamAPI.get_matches(start_at_seq_num)
    if data and data['result'] and data['result']['matches'].count
      count = 0
      data['result']['matches'].each do |match|
        if Match.where(match_id: match['match_id']).count == 0
          count+=1
          s = Redis::Semaphore.new(:add_to_queue)
          s.lock do
            Mqueue.find_or_create_by(match_id: match['match_id']).save
          end
        end
      end
      logger.error "Added #{count} full"
      if data['result']['matches'].last and (last_num = data['result']['matches'].last['match_seq_num'])
          ScannerStatus.first().update(match_seq_num: data['result']['matches'].last['match_seq_num'])
      end
    end
  end

  def perform(*args)
    # Do something later
    get_json
    sleep(5)
    queue = Sidekiq::Queue.new(:full_scan)
    ([queue.limit.to_i, 5].max - queue.size.to_i).times do
      self.class.perform_later
    end
    logger.info "finished scan #{self.queue_name}"
  end
end
