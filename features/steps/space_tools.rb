class Spinach::Features::SpaceTools < Spinach::FeatureSteps
  include ApiTasks

  step 'I make request with method create to add message tool' do
    create_tool 21
  end

  step 'I have a message tool' do
    create_tool 21
  end

  step 'I have a git tool' do
    create_tool 128
  end

  step 'I make request with method get' do
    @response = @instance.get @space.wiki_name, @tool.id
  end

  step 'I make request with method edit' do
    @response = @instance.edit @space.wiki_name, @tool.id, space_tool: {watcher_permissions: 1}
  end

  step 'I make request with method delete' do
    @response = @instance.delete @space.wiki_name, @tool.id
  end

  step 'I make request with method list' do
    @response = @instance.list @space.wiki_name
  end

  step 'I make request with method repo_list' do
    @response = @instance.repo_list @space.wiki_name
  end

  step 'I have "Assembla::Client::Spaces::SpaceTools" instance' do
    @instance = @tool_api = Assembla::Client::Spaces::SpaceTools.new
  end
end
