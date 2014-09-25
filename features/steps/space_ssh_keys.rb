class Spinach::Features::SpaceSshKeys < Spinach::FeatureSteps
  include ApiTasks

  step 'I have a space ssh key' do
    @response = @instance.generate @space.wiki_name
  end

  step 'I make request with method get' do
    @response = @instance.get @space.wiki_name
  end

  step 'I make request with method generate' do
    i_have_a_space_ssh_key
  end

  step 'I have "Assembla::Client::Spaces::Ssh::Keys" instance' do
    @instance = Assembla::Client::Spaces::Ssh::Keys.new
  end

  step 'I use specific space name' do
    @space_name = 'Space SSH Keys API'
  end
end
