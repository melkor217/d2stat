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
  has_many :players

  index({ match_id: 1 }, { unique: true})
end
