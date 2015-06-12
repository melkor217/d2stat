require 'net/http'

class ProcessMatchJob < ActiveJob::Base
  include Sidekiq::Worker
  queue_as :process_match

  def perform(*args)
    # Do something later
    rqueue = :mq_high
    r = Redis.new
    if r.scard(rqueue) < 25
      rqueue = :mq
    end
    20.times do
      if r.scard(rqueue) < 25
        break
      end
      qmatch, skill = r.spop(rqueue).to_s.split
      if qmatch == nil
        logger.info 'q is empty :('
        break
      end
      s = Redis::Semaphore.new('match:'+qmatch.to_s, expiration: 600)
      next if s.exists?
      logger.info "/locking #{qmatch} #{rqueue}"
      s.lock do
        logger.info "processing #{qmatch}"
        if Match.add_match(qmatch, skill)
          logger.info "done #{qmatch}"
        else
          logger.info "will retry later #{qmatch}"
        end
      end
      logger.info "/unlocking #{qmatch}"
      s.unlock
      s.delete!
    end
    queue = Sidekiq::Queue.new(:process_match)
    ([queue.limit.to_i, 50].max - queue.size.to_i).times do
      self.class.perform_later
    end
  end

  logger.info "finished proc #{self.queue_name}"
end


