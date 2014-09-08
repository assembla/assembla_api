class Spinach::Features::Events < Spinach::FeatureSteps
  include ApiTasks

  step 'I make request with method list' do
    @response = @instance.list
  end

  step 'I have "Assembla::Client::Activity" instance' do
    @instance = Assembla::Client::Activity.new
  end
end
