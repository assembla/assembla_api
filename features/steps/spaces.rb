class Spinach::Features::Spaces < Spinach::FeatureSteps
  include ApiTasks

  step 'I make request with method my' do
    @response = @instance.my
  end

  step 'I have "Assembla::Client::Spaces" instance' do
    @instance = Assembla::Client::Spaces.new
  end

  step 'I make request with method get' do
    @response = @instance.get space: 'api-test'
  end

  step 'I make request with method create' do
    @response = @instance.create name: 'api-test'
  end
end
