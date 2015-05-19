json.array!(@ability_upgrades) do |ability_upgrade|
  json.extract! ability_upgrade, :id, :ability, :time, :level
  json.url ability_upgrade_url(ability_upgrade, format: :json)
end
