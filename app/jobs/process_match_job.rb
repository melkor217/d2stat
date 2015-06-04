require 'net/http'

class ProcessMatchJob < ActiveJob::Base
  include Sidekiq::Worker
  queue_as :process_match

  def perform(*args)
    # Do something later
    count = Mqueue.count
    if count > 100
      Mqueue.skip(rand(count-30)).limit(20).each do |qmatch|
        s = Redis::Semaphore.new(qmatch['match_id'], expiration: 600)
        next if s.exists?
        logger.info "/locking #{qmatch['match_id']}"
        s.lock do
          logger.info "processing #{qmatch['match_id']}"
          if Match.add_match(qmatch['match_id'], qmatch['skill'])
            qmatch.remove
          else
            logger.info "will retry later #{qmatch['match_id']}"
          end
        end
        logger.info "/unlocking #{qmatch['match_id']}"
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


