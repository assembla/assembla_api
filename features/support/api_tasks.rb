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
    @space = @space_api.create name: @space_name
    expect(@space.status).to eq 201
  end

  step 'I know my user ID' do
    @current_user = user_api.me
    expect(@current_user.status).to eq 200
    @current_user_id = @current_user.id
  end

  def create_ticket(params)
    @tickets_api ||= Assembla::Client::Spaces::Tickets.new
    @response = @ticket = @tickets_api.create @space.wiki_name, ticket: params
    expect(@ticket.status).to eq 201
    @ticket
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
    @user_role = @user_role_api.create @space.wiki_name, user_role: {user_id: @dev1.id, role: 'member'}
    expect(@user_role.status).to eq 201
  end

  step 'I have a ticket tool' do
    create_tool 13
  end

  def create_tool(tool_id)
    @tool_api ||= Assembla::Client::Spaces::SpaceTools.new
    @response = @tool = @tool_api.create @space.wiki_name, tool_id
    expect(@tool.status).to eq 201
  end
end
