class Spinach::Features::SshActionLaunches < Spinach::FeatureSteps
  include ApiTasks

  step 'I make request with method list' do
    @response = @instance.list @space.wiki_name, @ssh_action.id
  end

  step 'I have "Assembla::Client::Spaces::Ssh::Actions::Launches" instance' do
    @instance = Assembla::Client::Spaces::Ssh::Actions::Launches.new
  end

  step 'I use specific space name' do
    @space_name = 'SSH Actions Launches API'
  end
end
