class Spinach::Features::PortfolioTasks < Spinach::FeatureSteps
  include ApiTasks

  step 'I make request with method list' do
    @response = @instance.list
  end

  step 'I have "Assembla::Client::Portfolio::Tasks" instance' do
    @instance = Assembla::Client::Portfolio::Tasks.new
  end
end
