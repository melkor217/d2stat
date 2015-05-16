json.array!(@accounts) do |account|
  json.extract! account, :id, :account_id, :last_check
  json.url account_url(account, format: :json)
end
