require 'vcr'

VCR.configure do |conf|
  conf.hook_into :webmock
  conf.cassette_library_dir = 'features/cassettes'
  conf.default_cassette_options = {
    :record => ENV['TRAVIS'] ? :none : :new_episodes,
    #:record => :all, # :new_episodes
    :serialize_with => :json,
    :preserve_exact_body_bytes  => true,
    :decode_compressed_response => true
  }
  conf.filter_sensitive_data('<API_KEY>') { SETTINGS['api_key'] }
  conf.filter_sensitive_data('<API_SECRET>') { SETTINGS['api_secret'] }
  conf.debug_logger = File.open('test.log', 'w')
end

Spinach.hooks.before_scenario do |scenario|
  record = scenario.tags.include?('live') ? :once : :new_episodes

  cassette = if record == :once
    rec_file = File.join(File.dirname(__FILE__) + '/../cassettes/tmp.json')
    File.delete rec_file if File.exists? rec_file
    'tmp'
  else
    File.join(scenario.feature.name.parameterize, scenario.name.parameterize)
  end

  VCR.insert_cassette(cassette, record: record)
end

Spinach.hooks.after_scenario do
  VCR.eject_cassette
end
