require 'net/http'

class ProcessMatchJob < ActiveJob::Base
  include Sidekiq::Worker
  queue_as :process_match

  def perform(*args)
    # Do something later
    rqueue = :mq_high
    r = RedisSession
    if r.scard(rqueue) < 25
      rqueue = :mq
    end
    t = Time.now
    count = 0
    failcount = 0
    while Time.now < (t+60+rand(5)) do
      if r.scard(rqueue) < 25
        sleep 10
        break
      end
      qmatch, skill = r.spop(rqueue).to_s.split
      if qmatch == nil
        logger.info 'q is empty :('
        break
      end
      #next if rqueue == :mq_high and not skill and rand(2) != 0
      s = Redis::Semaphore.new('match:'+qmatch.to_s, expiration: 60, redis: RedisSession)
      next if s.exists?
      s.lock do
        if (ret = Match.add_match(qmatch, skill))
          logger.info "done #{qmatch}"
          count+=1
        else
          logger.info "will retry later #{qmatch} #{ret}"
          failcount
        end
      end
      s.unlock
      s.delete!
    end
    logger.info "processed #{count} matches, failcount #{failcount}"
    queue = Sidekiq::Queue.new(:process_match)
    ([queue.limit.to_i, 50].max - queue.size.to_i).times do
      self.class.perform_later
    end
  end

  logger.info "finished proc #{self.queue_name}"
end


