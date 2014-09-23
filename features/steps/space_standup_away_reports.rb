class Spinach::Features::SpaceStandupAwayReports < Spinach::FeatureSteps
  include ApiTasks

  step 'I make request with method create' do
    create_away_report
  end

  step 'I have a standup away report' do
    create_away_report
  end

  def create_away_report
    @response = @standup = @instance.create @space.wiki_name,
      standup_report: {
        what_i_will_do: 'Will be away',
        filled_for: @report_date.strftime
      }
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
    @instance = Assembla::Client::Spaces::StandupAwayReports.new
  end

  step 'I use specific space name' do
    @space_name = 'Standup Away Reports'
  end

  step 'I have a standup tool' do
    create_tool 10
  end

  step 'I want to see/create away reports 7 days ahead' do
    @report_date = Date.today + 7
  end
end
