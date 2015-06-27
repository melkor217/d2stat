module StatProcessor
  def self.perform(match, players)
    winrate(match, players)
    avg_xpm_gpm(match, players)
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

  def self.avg_xpm_gpm(match, players)
    record = Avgstat.find_or_create_by(skill: match.skill, day: match.start_day, duration: (match.duration/300).to_i, mode: match.mode_id)
    xpm = 0
    gpm = 0
    kills = 0
    lasthits = 0
    denies = 0

    players.each do |player|
      xpm += player.xp_per_min
      gpm += player.gold_per_min
      kills += player.kills
      lasthits += player.last_hits
      denies += player.denies
    end
    record.inc(xpm: xpm,
               gpm: gpm,
               kills: kills,
               lasthits: lasthits,
               denies: denies,
               matchcount: 1,
               totalduration: match.duration
    )
    record.save
  end
end
