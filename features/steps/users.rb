class Spinach::Features::Users < Spinach::FeatureSteps
  include ApiTasks

  step 'I make request with method me' do
    @response = @instance.me
  end

  step 'I make request with method get for user dev1' do
    @response = @instance.get user: 'dev1'
  end

  step 'I make request with method picture for me' do
    @response = @instance.picture 'mike'
  end

  step 'I have "Assembla::Client::Users" instance' do
    @instance = @user_api = Assembla::Client::Users.new
  end
end
