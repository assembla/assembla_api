class Spinach::Features::PortfolioUsers < Spinach::FeatureSteps
  include ApiTasks

  step 'I make request with method list' do
    @response = @instance.list
  end

  step 'I have "Assembla::Client::Portfolio::Users" instance' do
    @instance = Assembla::Client::Portfolio::Users.new
  end
end
