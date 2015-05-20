json.array!(@scanner_statuses) do |scanner_status|
  json.extract! scanner_status, :id, :match_seq_num
  json.url scanner_status_url(scanner_status, format: :json)
end
