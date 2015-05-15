class Match
  include Mongoid::Document
  field :match_id, type: Integer
  field :match_seq_num, type: Integer
  field :start_time, type: Integer
  field :lobby_type, type: Integer
  field :radiant_team_id, type: Integer
  field :dire_team_id, type: Integer
end
