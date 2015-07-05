require 'net/http'

class ProcessPlayersJob < ActiveJob::Base
  include Sidekiq::Worker
  queue_as :process_players

  def get_json(account_id, start_at_match_id=nil)
    data = DotaLimited::get('IDOTA2Match_570', 'GetMatchHistory', account_id: account_id, start_at_match_id: start_at_match_id, api_version: 'v1')
    if not data.empty? and data['result'] and data['result']['num_results'].to_i > 0
      logger.info "start from #{start_at_match_id}"
      count = 0
      if not data['result']
        return false
      end
      data['result']['matches'].each do |match|
        if Match.where(id: match['match_id']).count == 0
          count += 1
          if not @r.sismember(:mq_high, "#{match['match_id']} 1") and
              not @r.sismember(:mq_high, "#{match['match_id']} 2") and
              not @r.sismember(:mq_high, "#{match['match_id']} 3")
            @r.sadd(:mq, match['match_id'])
          end
        end
        #Match.add_match match
      end
      logger.info "Added #{count} of #{account_id}"
      if data['result']['results_remaining'].to_i > 0
        get_json(account_id, data['result']['matches'].last['match_id'])
      end
    end
    return true
  end

  def perform()
    @r = RedisSession
    # Do something later
    high_prio = Pqueue.where(:prio.gt => 9)
    if high_prio.count > 0
      pq = high_prio
    else
      pq = Pqueue
    end
    sleep 2
    30.times do
      t = Time.now
      if pq.count < 1 or @r.scard('mq') > 3000
        sleep 10
        break
      end
      pq.limit(5).each do |account|
        logger.info("Getting info from acc: #{account['account_id']}")
        if get_json(account['account_id'])
          account.delete
        end
      end
      sleep [t+8.1 - Time.now, 0.1].max
    end
    queue = Sidekiq::Queue.new(:process_players)
    ([queue.limit.to_i, 10].max - queue.size.to_i).times do
      self.class.perform_later
    end
  end

  logger.info "finished proc #{self.queue_name}"
end

