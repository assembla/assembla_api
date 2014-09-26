class Spinach::Features::SshActions < Spinach::FeatureSteps
  include ApiTasks

  step 'I make request with method create' do
    i_have_a_ssh_action
  end

  step 'I make request with method get' do
    @response = @instance.get @space.wiki_name, @ssh_action.id
  end

  step 'I make request with method edit' do
    @response = @instance.edit @space.wiki_name, @ssh_action.id,
      ssh_action: { description: 'Do small deploys' }
  end

  step 'I make request with method delete' do
    @response = @instance.delete @space.wiki_name, @ssh_action.id
  end

  step 'I make request with method run' do
    @response = @instance.run @space.wiki_name, @ssh_action.id
  end

  step 'I make request with method list' do
    @response = @instance.list @space.wiki_name
  end

  step 'I have "Assembla::Client::Spaces::Ssh::Actions" instance' do
    @ssh_actions_api = @instance = Assembla::Client::Spaces::Ssh::Actions.new
  end

  step 'I use specific space name' do
    @space_name = 'SSH Actions API'
  end
end
