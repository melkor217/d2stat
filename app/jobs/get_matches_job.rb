require 'net/http'

class GetMatchesJob < ActiveJob::Base
  include Sidekiq::Worker


  def get_json(skill, start_at_match_id=nil)
    logger.info 'getting data'
    data = DotaLimited.get_rt('IDOTA2Match_570', 'GetMatchHistory', skill: skill, start_at_match_id: start_at_match_id, api_version: 'v1')
    logger.info 'gotcha'
    if not data.empty? and data['result'] and data['result']['num_results'] > 0
      logger.info "start from #{start_at_match_id} (#{data['result']['matches'].count})"
      count = 0
      data['result']['matches'].each do |match|
        if Match.where(id: match['match_id']).count == 0
          if @r.sadd(:mq_high, "#{match['match_id']} #{skill}")
            count += 1
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
    @r = Redis.new
    # Do something later
      if Redis::Semaphore.new('get_matches_' + skill.to_s, expiration: 20).lock(25)
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
