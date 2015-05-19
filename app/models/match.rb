class Match
  include Mongoid::Document
  field :match_id, type: Integer
  field :match_seq_num, type: Integer
  field :start_time, type: Integer
  field :lobby_type, type: Integer
  field :radiant_team_id, type: Integer
  field :dire_team_id, type: Integer
  field :radiant_win, type: Boolean
  field :duration, type: Integer
  field :start_time, type: Integer
  field :tower_status_radiant, type: Integer
  field :tower_status_dire, type: Integer
  field :barracks_status_radiant, type: Integer
  field :barracks_status_dire, type: Integer
  field :cluster, type: Integer
  field :first_blood_time, type: Integer
  field :human_players, type: Integer
  field :leagueid, type: Integer
  field :positive_votes, type: Integer
  field :negative_votes, type: Integer
  field :game_mode, type: Integer
  field :radiant_captain, type: Integer
  field :dire_captain, type: Integer
  field :verbose, type: Boolean # have ve got verbose stats
  has_many :picks_bans
  has_many :players

  index({ match_id: 1 }, { unique: true})

  def self.add_match(match)
    count = Match.where(match_id: match['match_id']).count
    if count > 1
      logger.fatal 'ERROR COUNT %i %i' % [count, match['match_id']]
    end
    logger.debug count
    if Match.where(match_id: match['match_id']).count == 0
      details = SteamAPI::get_match(match['match_id'])
      if details and details['result']
        match = details['result']
        match['verbose'] = true
      end
      record = Match.new
      Player.add_players(match['players'], record)
      record.update(match.select { |key| key != 'players' })
      match['picks_bans'].each do |picks_ban|
        pickrecord = PicksBan.new(picks_ban)
        record.picks_bans.push pickrecord
        pickrecord.save
      end if match['picks_bans']
      logger.info('saved %s' % match['match_id'])
      record.save
    else
      logger.info('skip  %s' % match['match_id'])
    end
  end
end
