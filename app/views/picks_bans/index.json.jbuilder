json.array!(@picks_bans) do |picks_ban|
  json.extract! picks_ban, :id, :is_pick, :hero_id, :team, :order
  json.url picks_ban_url(picks_ban, format: :json)
end
