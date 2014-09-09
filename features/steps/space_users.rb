class Spinach::Features::SpaceUsers < Spinach::FeatureSteps
  include ApiTasks

  step 'I make request with method list' do
    @response = @instance.list @space.wiki_name
  end

  step 'I have "Assembla::Client::Spaces::Users" instance' do
    @instance = Assembla::Client::Spaces::Users.new
  end
end
