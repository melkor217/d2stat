json.array!(@matches) do |match|
  json.extract! match, :id, :match_id, :match_seq_num, :start_time, :lobby_type, :radiant_team_id, :dire_team_id
  json.url match_url(match, format: :json)
end
