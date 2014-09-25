class Spinach::Features::PortfolioStandupReports < Spinach::FeatureSteps
  include ApiTasks

  step 'I have a report for today' do
    create_standup_report
  end

  step 'I make request with method list' do
    @response = @instance.list
  end

  step 'I have an away report for next week day' do
    create_away_report
  end

  step 'I make request with method list away' do
    @response = @instance.away to: @report_date.strftime
  end

  step 'I have a report with roadblocks' do
    create_standup_report roadblocks: 'I need more tasks'
  end

  step 'I make request with method list with needs' do
    @response = @instance.with_needs
  end

  step 'I have "Assembla::Client::Portfolio::StandupReports" instance' do
    @instance = Assembla::Client::Portfolio::StandupReports.new
  end

  step 'I have a space with standup tool' do
    i_have_a_space
    i_have_a_standup_tool
  end
end
