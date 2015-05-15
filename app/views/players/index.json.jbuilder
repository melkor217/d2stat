json.array!(@players) do |player|
  json.extract! player, :id, :account_id, :player_slot, :hero_id
  json.url player_url(player, format: :json)
end
