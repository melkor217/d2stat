require 'net/http'

VERY_FIRST_MATCH = 240
# 240 is hardcoded match_seq_id of the first match


class FullScanJob < ActiveJob::Base
  include Sidekiq::Worker
  queue_as :full_scan

  def get_json()
    # Scan sequentially from the first
    entry = ScannerStatus.where(name: 'full').first()
    if entry
      start_at_seq_num = entry.match_seq_num
    end
    if not start_at_seq_num

      ScannerStatus.new(match_seq_num: VERY_FIRST_MATCH, name: 'full').save
      start_at_seq_num = VERY_FIRST_MATCH
      logger.warn 'NO SEQ NUMBER'
    end
    data = DotaLimited::get('IDOTA2Match_570', 'GetMatchHistoryBySequenceNum', start_at_match_seq_num: start_at_seq_num, api_version: 'v1')
    if data and data['result'] and data['result']['matches'].count
      count = 0
      data['result']['matches'].each do |match|
        if not Match.where(id: match['match_id']).exists?
          count += 1
          if not @r.sismember(:mq_high, "#{match['match_id']} 1") and
              not @r.sismember(:mq_high, "#{match['match_id']} 2") and
              not @r.sismember(:mq_high, "#{match['match_id']} 3")
            @r.sadd(:mq, match['match_id'])
          end
        end
      end
      logger.info "Added #{count} full"
      if data['result']['matches'].last and (last_num = data['result']['matches'].last['match_seq_num'])
          ScannerStatus.where(name: 'full').first().update(match_seq_num: data['result']['matches'].last['match_seq_num'], start_time: DateTime.strptime(data['result']['matches'].last['start_time'].to_s, '%s'))
      end
    end
  end

  def perform(*args)
    t = Time.now
    @r = RedisSession
    # We perform full scan only if we are out of matches to process
    if @r.scard('mq') > 3000
      logger.info('sleep')
      sleep 10
    else
      get_json
    end
    sleep [t+5.1 - Time.now, 0.1].max
    queue = Sidekiq::Queue.new(:full_scan)
    (5 - queue.size.to_i).times do
      self.class.perform_later
    end
    logger.info "finished scan #{self.queue_name}"
  end
end
