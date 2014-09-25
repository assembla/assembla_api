class Spinach::Features::SpaceStandupAwayReports < Spinach::FeatureSteps
  include ApiTasks

  step 'I make request with method create' do
    create_away_report
  end

  step 'I make request with method edit' do
    @response = @instance.edit @space.wiki_name,
      standup_report: { what_i_will_do: 'I will take a vacation'},
      date: @report_date.strftime
  end

  step 'I make request with method my' do
    @response = @instance.my @space.wiki_name, date: @report_date.strftime
  end

  step 'I make request with method list' do
    @response = @instance.list @space.wiki_name, date: @report_date.strftime
  end

  step 'I have "Assembla::Client::Spaces::StandupAwayReports" instance' do
    @standup_away_api = @instance = Assembla::Client::Spaces::StandupAwayReports.new
  end

  step 'I use specific space name' do
    @space_name = 'Standup Away Reports'
  end
end
