class Player
  # Player means not account, but "dat pudga in dis gaem"
  include Mongoid::Document

  field :account_id, type: BigDecimal
  field :player_slot, type: Integer
  field :personaname, type: String
  field :item_0, type: Integer
  field :item_1, type: Integer
  field :item_2, type: Integer
  field :item_3, type: Integer
  field :item_4, type: Integer
  field :item_5, type: Integer
  field :kills, type: Integer
  field :deaths, type: Integer
  field :assists, type: Integer
  field :leaver_status, type: Integer
  field :gold, type: Integer
  field :last_hits, type: Integer
  field :denies, type: Integer
  field :xp_per_min, type: Integer
  field :gold_per_min, type: Integer
  field :hero_damage, type: Integer
  field :tower_damage, type: Integer
  field :hero_healing, type: Integer
  field :gold_spent, type: Integer
  field :level, type: Integer
  field :skill, type: Integer

  field :winner, type: Boolean

  embeds_many :ability_upgrades
  embeds_many :additional_units
  belongs_to :match, index: true
  belongs_to :hero
  belongs_to :account, index: true

  field :_id, type: String, default: ->{ match_id.to_s + '.' + player_slot.to_s }

  def is_radiant?
    return (0..4).include? player_slot
  end

  def is_dire?
    return (128..132).include? player_slot
  end

  def item_list
    return [item_0, item_1, item_2, item_3, item_4, item_5]
  end

  def items
    item_list.map do |item|
      Item.find(item)
    end
  end

  def self.add_players(players, match)
    # array of 64bit account_ids
    steam_ids = []
    players.each do |player|
      if player and player['account_id']
        steam_ids.append(player['account_id'] + 76561197960265728)
      end
    end
    accounts_data = DotaLimited.get('ISteamUser', 'GetPlayerSummaries', steamids: steam_ids.join(','), api_version: 'v2')
    if accounts_data and
        accounts_data['response'] and
        accounts_data['response']['players'].count
      accounts = accounts_data['response']['players']
    else
      accounts = []
    end
    logger.info "#{accounts.size} accounts"
    records = players.map do |player|
      matched_accs = accounts.select do |account|
        player['account_id'].to_i == (-76561197960265728 + account['steamid'].to_i)
      end
      if matched_accs.first
        player['personaname'] = matched_accs.first['personaname']
      end
      # database records for each player
      player['match_id'] = match.id
      record = Player.new(player)
      record.skill = match.skill
      if record.is_radiant? == !!match.radiant_win
        record.winner = true
      else
        record.winner = false
      end
      player['ability_upgrades'].each do |abi_upgrade|
        abirecord = record.ability_upgrades.new(abi_upgrade)
        record.ability_upgrades.append abirecord
      end if player['ability_upgrades']
      player['additional_units'].each do |additional_unit|
        unitrecord = record.additional_units.new(additional_unit)
        record.additional_units.append unitrecord
      end if player['additional_units']
      #match.players.push player
      #record.match = match
      record.update(player.select { |key| key != 'ability_upgrades' and key != 'additional_units' })
      Account.add_account(accounts, player['account_id'], record)
      record
    end
    records
  end
end
