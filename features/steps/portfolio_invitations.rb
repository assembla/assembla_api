class Spinach::Features::PortfolioInvitations < Spinach::FeatureSteps
  include ApiTasks

  step 'I make request with method create' do
    i_have_an_invitation
  end

  step 'I have an invitation' do
    @response = @instance.create invitation: {identifiers: ["api-test#{Time.now.to_i}@breakout.tld"], role: 100 }
    @invitation = @response.first
  end

  step 'I make request with method list' do
    @response = @instance.list
  end

  step 'I make request with method get' do
    @response = @instance.get @invitation.id
  end

  step 'I have "Assembla::Client::Portfolio::Invitations" instance' do
    @instance = Assembla::Client::Portfolio::Invitations.new
  end
end
