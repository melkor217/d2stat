# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

regions = JSON.parse(IO.read('data/regions.json'))
if regions['regions']
  Region.all.delete
  regions['regions'].each do |region|
    Region.new(region).save
  end
end

lobbies = JSON.parse(IO.read('data/lobbies.json'))
if lobbies['lobbies']
  Lobby.all.delete
  lobbies['lobbies'].each do |lobby|
    Lobby.new(lobby).save
  end
end

modes = JSON.parse(IO.read('data/modes.json'))
if modes['modes']
  Mode.all.delete
  modes['modes'].each do |mode|
    Mode.new(mode).save
  end
end

heroes = JSON.parse(IO.read('data/heroes.json'))
if heroes['heroes']
  Hero.all.delete
  heroes['heroes'].each do |hero|
    Hero.new(hero).save
  end
end

Pqueue.find_or_create_by(account_id: 106866396)
