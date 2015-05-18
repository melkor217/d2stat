class SteamAPI

  def self.get_key
    key = Key.find_by(name: 'development').value
  end

  def self.get_history_url(start_at_match_id=nil)
    key = self.get_key()
    key_arg = "key=#{key}&"
    start_arg = ''
    if start_at_match_id
      start_arg = "start_at_match_id=#{start_at_match_id}&"
    end
    url = 'https://api.steampowered.com/IDOTA2Match_570/GetMatchHistory/V001/?'+start_arg+key_arg
    Rails.logger.info url
    return url
  end

  def self.get_history(start_at_match_id=nil)
    url = self.get_history_url(start_at_match_id)
    resp = Net::HTTP.get_response(URI.parse(url))
    data = JSON.parse(resp.body)
    return data
  end

  def self.get_account_url(account_id)
    key = self.get_key
    account_id64 = (account_id.to_i + 76561197960265728).to_i
    key_arg = "key=#{key}&"
    id_arg = "steamids=#{account_id64}&"
    url = 'https://api.steampowered.com/ISteamUser/GetPlayerSummaries/v0002/?'+id_arg+key_arg
  end

  def self.get_account(account_id)
    url = self.get_account_url(account_id)
    resp = Net::HTTP.get_response(URI.parse(url))
    data = JSON.parse(resp.body)
    return data
  end
end