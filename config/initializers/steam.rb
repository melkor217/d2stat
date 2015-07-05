steamcfg = YAML.load_file("#{Rails.root}/config/steamsecrets.yml")
current_env = steamcfg[Rails.env]
default_env = steamcfg['defaults']

if current_env and current_env['key']
  STEAM_CONFIG = current_env
elsif default_env and default_env['key']
  STEAM_CONFIG = default_env
else
  raise "Steam key is missing. Goto README.rdoc"
end

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :steam, STEAM_CONFIG['key']
end

Dotos = STEAM_CONFIG['scan_keys'].map do |key|
  q = Dota.clone
  q.configure do |config|
    config.api_key = key
  end
  q
end


Dota.configure do |config|
  config.api_key = STEAM_CONFIG['key']
end
