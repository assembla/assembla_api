module ApiTasks
  include Spinach::DSL

  [200, 201, 204, 404].each do |code|
    step "the response status should be #{code}" do
      expect(@response.status).to eq code
    end
  end

  step 'I have a space' do
    @space_api ||= Assembla::Client::Spaces.new
    @space = @space_api.create name: 'api-test'
    expect(@space.status).to eq 201
  end

  step 'I have user dev1' do
    @user_api ||= Assembla::Client::Users.new
    @dev1 = @user_api.get user: 'dev1'
    expect(@dev1.status).to eq 200
  end

  step 'I invite dev1 to the space' do
    @user_role_api ||= Assembla::Client::Spaces::UserRoles.new
    @user_role = @user_role_api.create @space.wiki_name, user_role: {user_id: @dev1.id, role: 'member'}
    expect(@user_role.status).to eq 201
  end

  def create_tool(tool_id)
    @response = @tool = @tool_api.create @space.wiki_name, tool_id
    expect(@tool.status).to eq 201
  end
end
