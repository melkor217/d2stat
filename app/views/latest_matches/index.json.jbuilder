json.array!(@latest_matches) do |latest_match|
  json.extract! latest_match, :id
  json.url latest_match_url(latest_match, format: :json)
end
