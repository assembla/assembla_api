class Spinach::Features::PortfolioSpaces < Spinach::FeatureSteps
  include ApiTasks

  step 'I make request with method list' do
    @response = @instance.list
  end

  step 'I have "Assembla::Client::Portfolio::Spaces" instance' do
    @instance = Assembla::Client::Portfolio::Spaces.new
  end
end
