class Spinach::Features::SpaceTickets < Spinach::FeatureSteps
  include ApiTasks

  step 'I use different space name' do
    @space_name = 'tickets-api'
  end

  step 'I have a ticket' do
    create_ticket summary: 'Existing one', description: 'Fix it ASAP'
  end

  step 'I have a ticket with tags' do
    create_ticket summary: 'With Tags', tags: %w{Core API}
  end

  step 'I have a ticket assigned to me' do
    create_ticket summary: 'Your first task', assigned_to_id: @current_user_id
  end

  step 'It has an attachment' do
    @doc_params = { attachable_id: @ticket.id, attachable_type: 'Ticket' }
    i_have_a_document
  end

  step 'I have a current milestone' do
    create_milestone
  end

  step 'I have a ticket with milestone current' do
    create_ticket summary: 'Backlog ticket', milestone_id: @milestone.id
  end

  step 'I have a custom report' do
    # There is no way to create custom report with API
  end

  step 'I make request with method create' do
    @response = @instance.create @space.wiki_name, summary: 'First one', description: 'Fix it soon'
  end

  step 'I make request with method get by number' do
    @response = @instance.get @space.wiki_name, @ticket.number
  end

  step 'I make request with method get by id' do
    @response = @instance.get_by_id @space.wiki_name, @ticket.id
  end

  step 'I make request with method edit' do
    @response = @instance.edit @space.wiki_name, @ticket.number, description: 'Maybe later', priority: 2
  end

  step 'I make request with method delete' do
    @response = @instance.delete @space.wiki_name, @ticket.number
  end

  step 'I make request with method list' do
    @response = @instance.list @space.wiki_name
  end

  step 'I make request with method attachments' do
    @response = @instance.attachments @space.wiki_name, @ticket.number
  end

  step 'I make request with method tags' do
    @response = @instance.tags @space.wiki_name, @ticket.number
  end

  step 'I make request with method custom reports' do
    @response = @instance.custom_reports @space.wiki_name
  end

  step 'I make request with method my' do
    @response = @instance.my @space.wiki_name
  end

  step 'I make request with method followed' do
    @response = @instance.followed @space.wiki_name
  end

  step 'I make request with method by_milestone_id' do
    @response = @instance.by_milestone_id @space.wiki_name, @milestone.id
  end

  step 'I make request with method without_milestone' do
    @response = @instance.without_milestone @space.wiki_name
  end

  step 'I have "Assembla::Client::Spaces::Tickets" instance' do
    @instance = @tickets_api = Assembla::Client::Spaces::Tickets.new
  end
end
