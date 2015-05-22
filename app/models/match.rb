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
  field :radiant_name, type: String
  field :dire_name, type: String
  field :radiant_logo, type: String
  field :dire_logo, type: String
  field :radiant_team_complete, type: Integer
  field :dire_team_complete, type: Integer
  field :radiant_guild_id, type: Integer
  field :dire_guild_id, type: Integer
  field :radiant_guild_name, type: String
  field :dire_guild_name, type: String
  field :radiant_guild_logo, type: String
  field :dire_guild_logo, type: String
  field :rev, type: Integer # internal
  field :skill, type: Integer # internal
  embeds_many :picks_bans
  has_many :players

  index({ match_id: 1 }, { unique: true})

  def self.add_match(match_id, skill=nil)
    count = Match.where(match_id: match_id).count
    if count > 1
      logger.fatal 'ERROR COUNT %i %i' % [count, match_id]
    end
    logger.debug count
    if Match.where(match_id: match_id).count == 0
      details = SteamAPI::get_match(match_id)
      if details and details['result']
        details['result']['rev'] = 1
      else
        Rails.logger.error "No details #{match_id}"
        return false
      end
      record = Match.new
      if skill
        record.skill = skill
      end
      Player.add_players(details['result']['players'], record)
      record.update(details['result'].select { |key| key != 'players' and key != 'picks_bans' })
      details['result']['picks_bans'].each do |picks_ban|
        pickrecord = PicksBan.new(picks_ban)
        record.picks_bans.push pickrecord
        pickrecord.save
      end if details['result']['picks_bans']
      logger.info('saved %s' % match_id)
      record.save
    else
      logger.info('skip  %s' % match_id)
    end
  end
end
