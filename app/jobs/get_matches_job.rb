require 'net/http'

class GetMatchesJob < ActiveJob::Base
  queue_as :default

  def perform(*args)
    # Do something later
    resp = Net::HTTP.get_response(URI.parse('https://api.steampowered.com/IDOTA2Match_570/GetMatchHistory/V001/?key=579DD7729A7A4A6AE9DC5CA730B9644E'))
    data = JSON.parse(resp.body)
    logger.error 'dafuq lol??'
    if data['result']['status']
      data['result']['matches'].each do |match|
        logger.error match
        record = Match.new
        logger.error record.changed?
        record.match_id = match['match_id']
        record.match_seq_num = match['match_seq_num']
        record.start_time = match['start_time']
        record.lobby_type = match['lobby_type']
        record.radiant_team_id = match['radiant_team_id']
        record.dire_team_id = match['dire_team_id']
        record.save
      end
      return
    end
  end
end
