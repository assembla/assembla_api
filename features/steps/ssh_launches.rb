class Spinach::Features::SshLaunches < Spinach::FeatureSteps
  include ApiTasks

  step 'I make request with method list' do
    @response = @instance.list @space.wiki_name
  end

  step 'I know ssh launch id' do
    i_make_request_with_method_list
    expect(@response.status).to eq 200
    @ssh_launch = @response.first
  end

  step 'I make request with method get' do
    @response = @instance.get @space.wiki_name, @ssh_launch.id
  end

  step 'I make request with method output' do
    @response = @instance.output @space.wiki_name, @ssh_launch.id
  end

  step 'I have "Assembla::Client::Spaces::Ssh::Launches" instance' do
    @instance = Assembla::Client::Spaces::Ssh::Launches.new
  end

  step 'I use specific space name' do
    @space_name = 'SSH Launches API'
  end
end
