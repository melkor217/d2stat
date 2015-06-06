require 'net/http'

class ProcessMatchJob < ActiveJob::Base
  include Sidekiq::Worker
  queue_as :process_match

  def perform(*args)
    # Do something later
    r = Redis.new
    count = r.scard('mq')
    if count > 100
      20.times do
        qmatch, skill = r.spop('mq').to_s.split
        if qmatch == nil
          logger.info 'q is empty :('
          break
        end
        s = Redis::Semaphore.new(qmatch, expiration: 600)
        next if s.exists?
        logger.info "/locking #{qmatch}"
        s.lock do
          logger.info "processing #{qmatch}"
          if Match.add_match(qmatch, skill)
            logger.info "done #{qmatch}"
          else
            logger.info "will retry later #{qmatch}"
          end
        end
        logger.info "/unlocking #{qmatch}"
        s.delete!
      end
      queue = Sidekiq::Queue.new(:process_match)
      ([queue.limit.to_i, 50].max - queue.size.to_i).times do
        self.class.perform_later
      end
    end
  end

  logger.info "finished proc #{self.queue_name}"
end


