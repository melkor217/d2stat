json.array!(@accounts) do |account|
  json.extract! account, :id, :account_id, :steamid, :profilestate, :personaname, :lastlogoff, :profileurl, :avatar, :avatarmedium, :avatarfull, :personastate, :primaryclanid, :timecreated, :personastateflags, :gameextrainfo, :gameid, :loccountrycode, :locstatecode, :last_check
  json.url account_url(account, format: :json)
end
