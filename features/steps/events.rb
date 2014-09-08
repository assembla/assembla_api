class Spinach::Features::Events < Spinach::FeatureSteps
  step 'I make request with method list' do
    @response = @instance.list
  end

  step 'the response status should be 200' do
    expect(@response.status).to eq 200
  end

  step 'I have "Assembla::Client::Activity" instance' do
    @instance = Assembla::Client::Activity.new
  end
end
