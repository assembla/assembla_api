class Spinach::Features::TicketCustomFields < Spinach::FeatureSteps
  include ApiTasks

  step 'I make request with method create' do
    create_custom_field
  end

  step 'I have a ticket custom field' do
    create_custom_field('date')
  end

  def create_custom_field(type = 'text')
    @t_field = @response = @instance.create @space.wiki_name, custom_field: {title: 'Build', type: type }
    expect(@response.status).to eq 201
  end

  step 'I make request with method get' do
    @response = @instance.get @space.wiki_name, @t_field.id
  end

  step 'I make request with method edit' do
    @response = @instance.edit @space.wiki_name, @t_field.id, custom_field: {title: 'Build Number', type: 'numeric'}
  end

  step 'I make request with method delete' do
    @response = @instance.delete @space.wiki_name, @t_field.id
  end

  step 'I make request with method list' do
    @response = @instance.list @space.wiki_name
  end

  step 'I have "Assembla::Client::Spaces::Tickets::CustomFields" instance' do
    @instance = Assembla::Client::Spaces::Tickets::CustomFields.new
  end

  step 'I use specific space name' do
    @space_name = 'tickets-cf-api'
  end
end
