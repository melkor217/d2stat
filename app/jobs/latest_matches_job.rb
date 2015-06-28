require 'net/http'

class LatestMatchesJob < ActiveJob::Base
  include Sidekiq::Worker
  queue_as :latest_scan

  def get_json()
    # Scan sequentially from the first
    entry = ScannerStatus.where(name: 'latest').first()
    if entry
      start_at_seq_num = entry.match_seq_num
    end
    if not start_at_seq_num
      data = DotaLimited::get_rt('IDOTA2Match_570', 'GetMatchHistory', api_version: 'v1')
      if data and data['result'] and data['result']['matches'] and data['result']['matches'].last['match_seq_num'].to_i > 0
        start_at_seq_num = data['result']['matches'].last['match_seq_num']
        ScannerStatus.new(match_seq_num: start_at_seq_num, name: 'latest').save
        logger.info "Got latest seq number #{start_at_seq_num}"
      else
        logger.warn 'NO SEQ NUMBER (latest scan)'
        sleep 20
        return
      end
    end
    begin
      data = DotaLimited::get('IDOTA2Match_570', 'GetMatchHistoryBySequenceNum', start_at_match_seq_num: start_at_seq_num, api_version: 'v1')
    rescue Exception => e
      logger.info "latest scan threshold (#{e.class}), sleep 10"
      sleep 10
      return
    end

    if data and data['result'] and data['result']['matches'].count
      count = 0
      data['result']['matches'].each do |match|
        if Match.where(id: match['match_id']).count == 0
          count += 1
          if not @r.sismember(:mq_high, "#{match['match_id']} 1") and
              not @r.sismember(:mq_high, "#{match['match_id']} 2") and
              not @r.sismember(:mq_high, "#{match['match_id']} 3")
            @r.sadd(:mq_high, match['match_id'])
          end
        end
      end
      logger.info "Added #{count} latest_seq (#{start_at_seq_num})"
      if data['result']['matches'].last and (last_num = data['result']['matches'].last['match_seq_num'])
        ScannerStatus.where(name: 'latest').first().update(match_seq_num: last_num, start_time: DateTime.strptime(data['result']['matches'].last['start_time'].to_s, '%s'))
      end
    else
      sleep 10
    end
  end

  def perform(*args)
    @r = Redis.new
    # We perform full scan only if we are out of matches to process
    if @r.scard('mq_high') > 1000000
      logger.info('sleep')
      sleep 10
    else
      10.times do
        get_json
      end
    end
    queue = Sidekiq::Queue.new(:latest_scan)
    ([queue.limit.to_i, 5].max - queue.size.to_i).times do
      self.class.perform_later
    end
    logger.info "finished latest scan #{self.queue_name}"
  end
end
