module StatProcessor
  def self.perform(match, players)
    winrate(match, players)
  end

  def self.winrate(match, players)
    if match.lobby.name == 'Ranked'
      players.each do |player|
        record = Winrate.find_or_create_by(skill: player.skill, hero_id: player.hero_id, day: match.start_day)
        if player.winner
          record.inc(wins: 1)
        else
          record.inc(loses: 1)
        end
        record.save
      end
    end
    return true
  end
end
