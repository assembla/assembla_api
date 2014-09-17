class Spinach::Features::TicketStatuses < Spinach::FeatureSteps
  include ApiTasks

  step 'I make request with method create' do
    create_status
  end

  step 'I have a ticket status' do
    create_status
  end

  def create_status
    @tstatus = @response = @instance.create @space.wiki_name, status: {name: 'Deploy', state: 1}
    expect(@response.status).to eq 201
  end

  step 'I make request with method get' do
    @response = @instance.get @space.wiki_name, @tstatus.id
  end

  step 'I make request with method edit' do
    @response = @instance.edit @space.wiki_name, @tstatus.id, status: {name: 'Deploy to stage'}
  end


  step 'I make request with method delete' do
    @response = @instance.delete @space.wiki_name, @tstatus.id
  end

  step 'I make request with method list' do
    @response = @instance.list @space.wiki_name
  end

  step 'I have "Assembla::Client::Spaces::Tickets::Statuses" instance' do
    @instance = Assembla::Client::Spaces::Tickets::Statuses.new
  end

  step 'I use specific space name' do
    @space_name = 'tickets-statuses-api'
  end
end
