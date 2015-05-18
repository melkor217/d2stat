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

  def self.get_account_url(accont_id)
    key = self.get_key
    account_id64 = str(account_id + 76561197960265728)
    key_arg = "key=#{key}&"
    id_arg = "steamids=#{account_id}&"
    url = 'https://api.steampowered.com/ISteamUser/GetPlayerSummaries/v0002/?'+id_arg+key_arg
  end
end