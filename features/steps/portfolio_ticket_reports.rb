class Spinach::Features::PortfolioTicketReports < Spinach::FeatureSteps
  include ApiTasks

  step 'I make request with method list' do
    @response = @instance.list
  end

  step 'I have "Assembla::Client::Portfolio::TicketReports" instance' do
    @instance = Assembla::Client::Portfolio::TicketReports.new
  end
end
