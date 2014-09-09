class Spinach::Features::Spaces < Spinach::FeatureSteps
  include ApiTasks

  step 'I have "Assembla::Client::Spaces" instance' do
    @instance = Assembla::Client::Spaces.new
  end

  step 'I make request with method create' do
    @response = @instance.create name: 'api-test'
  end

  step 'I make request with method get' do
    @response = @instance.get space: 'api-test'
  end

  step 'I make request with method edit' do
    @response = @instance.edit space: @space.wiki_name,
      name: 'Edited api test',
      description: 'Sample api desc'
  end

  step 'I make request with method copy' do
    @response = @instance.copy space: @space.wiki_name,
      name: 'Copied api test',
      description: 'Copied Sample api desc'
  end

  step 'I make request with method my' do
    @response = @instance.my
  end

  step 'I make request with method delete' do
    @response = @instance.delete space: @space.wiki_name
  end

  step 'I have a space' do
    @space = @instance.create name: 'api-test'
    expect(@space.status).to eq 201
  end
end
