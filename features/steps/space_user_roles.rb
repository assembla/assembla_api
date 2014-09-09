class Spinach::Features::SpaceUserRoles < Spinach::FeatureSteps
  include ApiTasks

  step 'the user role should not be nil' do
    expect(@user_role).to be
  end

  step 'I change dev1 role to owner' do
    @response = @instance.edit @space.wiki_name, @user_role.id, user_role: {role: 'owner', title: 'New boss'}
  end

  step 'I make request with method delete' do
    @response = @instance.delete @space.wiki_name, @user_role.id
  end

  step 'I make request with method list' do
    @response = @instance.list @space.wiki_name
  end

  step 'I make request with method get' do
    @response = @instance.get @space.wiki_name, @user_role.id
  end

  step 'I have "Assembla::Client::Spaces::UserRoles" instance' do
    @instance = @user_role_api = Assembla::Client::Spaces::UserRoles.new
  end
end
