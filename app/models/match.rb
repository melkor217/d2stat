class Match
  include Mongoid::Document

  field :match_id, type: Integer
  field :match_seq_num, type: Integer
  field :start_time, type: DateTime
  field :lobby_type, type: Integer
  field :radiant_team_id, type: Integer
  field :dire_team_id, type: Integer
  field :radiant_win, type: Boolean
  field :duration, type: Integer
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
  field :scan_time, type: DateTime
  embeds_many :picks_bans
  has_many :players
  belongs_to :region
  belongs_to :lobby
  belongs_to :mode

  #index({ match_id: -1 }, { unique: true})
  index({ match_seq_num: -1 }, { unique: true})
  index({ start_time: -1 }, { unique: false})
  field :_id, type: Integer, default: ->{ match_id }

  def radiant_players()
    self.players.select do |player|
      player.is_radiant?
    end
  end

  def dire_players()
    self.players.select do |player|
      player.is_dire?
    end
  end

  def actual_players()
    radiant_players + dire_players
  end

  def start_day()
    Time.at(start_time.to_i - start_time.to_i.divmod(1.days.to_i).last)
  end

  def patch
    Patch.where(:date.lt => start_time).last
  end

  def self.add_match(match_id, skill=nil)
    existing_record = Match.where(id: match_id)
    logger.debug count
    if Match.where(id: match_id).count == 0
      begin
        details = DotaLimited::get('IDOTA2Match_570', 'GetMatchDetails', match_id: match_id, api_version: 'v1')
      rescue Exception => e
        logger.info "unable to get data (#{e.class})"
        sleep 5
        return 0
      end
      if details and details['result']
        details['result']['rev'] = 1
      else
        Rails.logger.error "No details #{match_id}"
        return false
      end

      filtered_defails = details['result'].select do |key|
         # fields we don't wanna save as is
         not %w{players pick_bans cluster start_time lobby_type game_mode}.include? key
      end

      if skill
        if existing_record.exists?
          record = existing_record
        else
          record = Match.new(filtered_defails)
        end
        record.skill = skill
      else
        if existing_record.exists?
          logger.fatal 'ERROR COUNT %i %i' % [count, match_id]
          return
        end
        record = Match.new(filtered_defails)
      end

      record.start_time = DateTime.strptime(details['result']['start_time'].to_s, '%s')
      record.region_id = details['result']['cluster']
      record.lobby_id = details['result']['lobby_type'].to_i
      record.mode_id = details['result']['game_mode'].to_i
      record.scan_time = Time.now
      details['result']['picks_bans'].each do |picks_ban|
        pickrecord = PicksBan.new(picks_ban)
        record.picks_bans.append pickrecord
      end if details['result']['picks_bans']
      if details['result']['players'].count > 0
        players = Player.add_players(details['result']['players'], record)
      else
        logger.info "no players for match #{match_id}"
        logger.info "json #{details['result']}"
      end
      logger.info('saved %s' % match_id)
      if record.save and players
        players.each do |player|
          player.save
        end
        StatProcessor::perform(record, players)
      end
    else
      logger.info('skip  %s' % match_id)
    end
  end
end
