require 'yaml'

def settings_file
  Pathname.new(File.expand_path("../../settings.yml", __FILE__))
end

def live_credentials?
  true
end

default_settings = {'api_key' => 'aaa', 'api_secret' => 'bbb'}
SETTINGS = (live_credentials? && File.exists?(settings_file) && yaml= YAML.load_file(settings_file)) ? yaml : default_settings

Assembla.configure do |conf|
  conf.ssl = { verify: false }
  conf.endpoint = SETTINGS['endpoint'] if SETTINGS['endpoint']
  conf.api_key = SETTINGS['api_key']
  conf.api_secret = SETTINGS['api_secret']
end
