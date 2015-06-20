module DotaLimited
  def self.get(*args)
    r = Ratelimit.new(:api_queries)
    while r.exceeded?(:match, interval: 600, threshold: Rails.configuration.dota_api_limit)
      Rails.logger.error 'Dota api threshold :('
      sleep 10
    end
    r.add :match
    Dota.api.get(*args)
  end
  def self.get_rt(*args)
    r = Ratelimit.new(:api_queries)
    r.add :match
    Dota.api.get(*args)
  end
end