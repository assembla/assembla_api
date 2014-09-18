class Spinach::Features::TicketComments < Spinach::FeatureSteps
  include ApiTasks

  def create_ticket_comment
    @tcomment = @response = @instance.create @space.wiki_name, @ticket.number,
        ticket_comment: {comment: 'Some WIP is done'}
    assert_created
  end

  step 'I make request with method create' do
    create_ticket_comment
  end

  step 'I have a ticket comment' do
    create_ticket_comment
  end

  step 'I make request with method get' do
    @response = @instance.get @space.wiki_name, @ticket.number, @tcomment.id
  end

  step 'I make request with method edit' do
    @response = @instance.edit @space.wiki_name, @ticket.number, @tcomment.id,
      ticket_comment: {comment: 'Some work is done'}
  end

  step 'I make request with method list' do
    @response = @instance.list @space.wiki_name, @ticket.number
  end

  step 'I have "Assembla::Client::Spaces::Tickets::Comments" instance' do
    @instance = Assembla::Client::Spaces::Tickets::Comments.new
  end

  step 'I use specific space name' do
    @space_name = 'Ticket Comments API'
  end
end
