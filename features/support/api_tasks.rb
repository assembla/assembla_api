module ApiTasks
  include Spinach::DSL

  [200, 201, 204, 404].each do |code|
    step "the response status should be #{code}" do
      expect(@response.status).to eq code
    end
  end

  step 'I have a space' do
    @space_name ||= 'api-test'
    @space_api ||= Assembla::Client::Spaces.new
    @space = @response = @space_api.create name: @space_name
    assert_created
  end

  step 'I have a milestone' do
    create_milestone
  end

  step 'I know my user ID' do
    @current_user = user_api.me
    expect(@current_user.status).to eq 200
    @current_user_id = @current_user.id
  end

  def create_ticket(params)
    @tickets_api ||= Assembla::Client::Spaces::Tickets.new
    @response = @ticket = @tickets_api.create @space.wiki_name, ticket: params
    assert_created
    @ticket
  end

  def assert_created
    expect(@response.status).to eq 201
  end

  def user_api
    @user_api ||= Assembla::Client::Users.new
  end

  step 'I have user dev1' do
    @dev1 = user_api.get user: 'dev1'
    expect(@dev1.status).to eq 200
  end

  step 'I invite dev1 to the space' do
    @user_role_api ||= Assembla::Client::Spaces::UserRoles.new
    @user_role = @response = @user_role_api.create @space.wiki_name, user_role: {user_id: @dev1.id, role: 'member'}
    assert_created
  end

  step 'I have a ticket tool' do
    create_tool 13
  end

  step 'I have a ticket' do
    @first_ticket = create_ticket summary: 'Make a plan for next project'
  end

  step 'I have a wiki tool' do
    create_tool Assembla::Constants::ToolTypes::WIKI
  end

  step 'I have a wiki page' do
    @wiki_api ||= Assembla::Client::Spaces::WikiPages.new

    params = { page_name: 'Setup', contents: 'TODO' }
    params.update(@wiki_params) if @wiki_params
    @wiki = @response = @wiki_api.create @space.wiki_name, wiki_page: params
  end

  def create_milestone(params = {})
    @milestones_api ||= Assembla::Client::Spaces::Milestones.new
    params[:title] ||= 'Backlog'
    @milestone = @response = @milestones_api.create @space.wiki_name, milestone: params
  end

  def create_tool(tool_id)
    @tool_api ||= Assembla::Client::Spaces::SpaceTools.new
    @response = @tool = @tool_api.create @space.wiki_name, tool_id
    assert_created
    @tool
  end
end
