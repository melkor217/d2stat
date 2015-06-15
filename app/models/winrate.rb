class Winrate
  include Mongoid::Document

  belongs_to :hero
  field :skill, type: Integer
  field :day, type: DateTime

  field :wins, type: Integer
  field :loses, type: Integer

  index({hero_id: 1, skill: -1, day: -1}, {unique: true})
end
