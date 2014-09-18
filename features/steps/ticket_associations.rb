class Spinach::Features::TicketAssociations < Spinach::FeatureSteps
  include ApiTasks

  step 'I make request with method create' do
    create_association
  end

  step 'I have another ticket' do
    create_another_ticket
  end

  step 'I have a ticket association' do
    create_another_ticket
    create_association
  end

  def create_another_ticket
    @child_ticket = create_ticket summary: 'Investigate new possibilities'
  end

  def create_association
    @tassociation = @response = @instance.create @space.wiki_name, @first_ticket.number,
        # subtask
        ticket_association: {ticket2_id: @child_ticket.id, relationship: 6}
    expect(@response.status).to eq 201
    @tassociation
  end

  step 'I make request with method get' do
    @response = @instance.get @space.wiki_name, @ticket.number, @tassociation.id
  end

  step 'I make request with method edit' do
    @response = @instance.edit @space.wiki_name, @ticket.number, @tassociation.id,
      # make it related
      ticket_association: {relationship: 2}
  end

  step 'I make request with method delete' do
    @response = @instance.delete @space.wiki_name, @ticket.number, @tassociation.id
  end

  step 'I make request with method list' do
    @response = @instance.list @space.wiki_name, @ticket.number
  end

  step 'I have "Assembla::Client::Spaces::Tickets::Associations" instance' do
    @instance = Assembla::Client::Spaces::Tickets::Associations.new
  end

  step 'I use specific space name' do
    @space_name = 'ticket assoc api'
  end
end
