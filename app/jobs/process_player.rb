require 'net/http'

class PPJob < ActiveJob::Base
  include Sidekiq::Worker
  queue_as :process_players

  def get_json(account_id, start_at_match_id=nil)
    data = Dota.api.get('IDOTA2Match_570', 'GetMatchHistory', 'v001', account_id: account_id, start_at_match_id: start_at_match_id)
    if not data.empty? and data['result'] and data['result']['num_results'] > 0
      logger.info "start from #{start_at_match_id}"
      count = 0
      data['result']['matches'].each do |match|
        if Match.where(match_id: match['match_id']).count == 0
          count += 1
          s = Redis::Semaphore.new(:add_to_queue)
          s.lock do
            Mqueue.find_or_create_by(match_id: match['match_id']).update(skill: skill)
          end
        end
        #Match.add_match match
      end
      logger.info "Added #{count} of #{account_id}"
      if data['result']['results_remaining'] > 0
        get_json(skill, data['result']['matches'].last['match_id'])
      end
    end
  end

  def perform()
    # Do something later
    count = Mqueue.count
    if count > 100
      Pqueue.limit(5).each do |account|
        get_json(account['account_id'])
      end
      queue = Sidekiq::Queue.new(:process_players)
      ([queue.limit.to_i, 10].max - queue.size.to_i).times do
        self.class.perform_later
      end
    end
  end

  logger.info "finished proc #{self.queue_name}"
end
