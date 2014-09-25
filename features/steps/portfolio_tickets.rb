class Spinach::Features::PortfolioTickets < Spinach::FeatureSteps
  include ApiTasks

  step 'I make request with method list' do
    @response = @instance.list
  end

  step 'I have "Assembla::Client::Portfolio::Tickets" instance' do
    @instance = Assembla::Client::Portfolio::Tickets.new
  end
end
