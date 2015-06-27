class Avgstat
  include Mongoid::Document

  field :xpm, type: Integer
  field :gpm, type: Integer
  field :kills, type: Integer
  field :lasthits, type: Integer
  field :denies, type: Integer
  field :matchcount, type: Integer
  field :totalduration, type: Integer

  field :skill, type: Integer
  field :mode, type: Integer
  field :duration, type: Integer # 1 == 5min
  field :day, type: DateTime

  index({skill: -1, day: -1, duration: -1, mode: -1}, {unique: true})
end
