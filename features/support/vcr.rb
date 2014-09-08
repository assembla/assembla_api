require 'vcr'

VCR.configure do |conf|
  conf.hook_into :webmock
  conf.cassette_library_dir = 'features/cassettes'
  conf.default_cassette_options = {
    #:record => ENV['TRAVIS'] ? :none : :once,
    :record => :all, # :new_episodes
    :serialize_with => :json,
    :preserve_exact_body_bytes  => true,
    :decode_compressed_response => true
  }
  conf.filter_sensitive_data('<API_KEY>') { SETTINGS['api_key'] }
  conf.filter_sensitive_data('<API_SECRET>') { SETTINGS['api_secret'] }
  conf.debug_logger = File.open('test.log', 'w')
end

#VCR.cucumber_tags do |t|
#  t.tag '@live', :record => :all
#end

Spinach.hooks.before_scenario do |scenario|
  VCR.insert_cassette(File.join(scenario.feature.name.parameterize, scenario.name.parameterize)) # .parameterize
end

Spinach.hooks.after_scenario do
  VCR.eject_cassette
end
