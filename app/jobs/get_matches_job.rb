require 'net/http'

class GetMatchesJob < ActiveJob::Base
  include Sidekiq::Worker


  def get_json(skill, start_at_match_id=nil)
    logger.info 'getting data'
    data = DotaLimited.get('IDOTA2Match_570', 'GetMatchHistory', 'v001', skill: skill, start_at_match_id: start_at_match_id)
    logger.info 'gotcha'
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
      logger.info "Added #{count} latest skill #{skill}"
      if data['result']['results_remaining'] > 0
        get_json(skill, data['result']['matches'].last['match_id'])
      end
    end
  end

  def perform(skill)
    # Do something later
      if Redis::Semaphore.new('get_matches_' + skill.to_s, expiration: 10).lock(12)
        # We don't unlock mutex cuz of reasons
        get_json(skill)
      end
      queue = Sidekiq::Queue.new(self.queue_name)
      ([queue.limit.to_i, 5].max - queue.size.to_i).times do
        self.class.set(queue: self.queue_name).perform_later skill
      end
      logger.info "finished scan #{self.queue_name}"
  end
end
