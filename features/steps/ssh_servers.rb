class Spinach::Features::SshServers < Spinach::FeatureSteps
  include ApiTasks

  step 'I make request with method create' do
    i_have_a_ssh_server
  end

  step 'I have a ssh server' do
    @server = @response = @instance.create @space.wiki_name,
      ssh_server: {
        name: 'Stage',
        remote_host: 'localhost', remote_port: 22
      }

    assert_created
  end

  step 'I make request with method get' do
    @response = @instance.get @space.wiki_name, @server.id
  end

  step 'I make request with method edit' do
    @response = @instance.edit @space.wiki_name, @server.id,
      ssh_server: { description: 'Do not deploy for a while!' }
  end

  step 'I make request with method delete' do
    @response = @instance.delete @space.wiki_name, @server.id
  end

  step 'I make request with method list' do
    @response = @instance.list @space.wiki_name
  end

  step 'I have "Assembla::Client::Spaces::Ssh::Servers" instance' do
    @instance = Assembla::Client::Spaces::Ssh::Servers.new
  end

  step 'I use specific space name' do
    @space_name = 'SSH Servers API'
  end

  step 'I have a ssh tool' do
    create_tool Assembla::Constants::ToolTypes::SSH
  end
end
