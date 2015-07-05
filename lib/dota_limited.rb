module DotaLimited
  def self.get(*args)
    while APILimit.exceeded?(:match, interval: 600, threshold: Rails.configuration.dota_api_limit)
      Rails.logger.error 'Dota api threshold :('
      sleep 10
    end
    APILimit.add :match
    Dota.api.get(*args)
  end
  def self.get_rt(*args)
    APILimit.add :match
    Dota.api.get(*args)
  end
  def self.get2(*args)
    APILimit.add :match
    Dotos.sample.api.get(*args)
  end
end