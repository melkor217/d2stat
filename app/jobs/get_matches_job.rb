require 'net/http'

class GetMatchesJob < ActiveJob::Base
  queue_as :default


  def get_url(start_at_match_id=nil)
    key='579DD7729A7A4A6AE9DC5CA730B9644E'
    key_arg = "key=#{key}&"
    start_arg = ''
    if start_at_match_id
      start_arg = "start_at_match_id=#{start_at_match_id}&"
    end
    url = 'https://api.steampowered.com/IDOTA2Match_570/GetMatchHistory/V001/?'+start_arg+key_arg
    logger.error url
    return url
  end

  def get_json(start_at_match_id=nil)
    resp = Net::HTTP.get_response(URI.parse(get_url(start_at_match_id)))
    data = JSON.parse(resp.body)
    if data.empty?
      return
    end
    if data['result']['num_results'] > 0
      if data['result']['status']
        logger.info "start from #{start_at_match_id}"
        data['result']['matches'].each do |match|
          count =  Match.where(match_id: match['match_id']).count
          if count > 1
            logger.fatal 'ERROR COUNT %i %i' % [count, match['match_id']]
          end
          logger.debug count
          if Match.where(match_id: match['match_id']).count == 0
            record = Match.new
            match.delete('players')
            record.from_json(match.to_json)
            logger.info('saved %s' % match['match_id'])
            record.save
          end
        end
      end
      if data['result']['results_remaining'] > 0
        get_json(data['result']['matches'].last['match_id'])
      end
    end
  end

  def perform(*args)
    # Do something later
    get_json
    logger.error @qwe
  end
end
