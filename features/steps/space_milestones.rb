class Spinach::Features::SpaceMilestones < Spinach::FeatureSteps
  include ApiTasks

  step 'I make request with method create' do
    create_milestone
  end

  step 'I make request with method get' do
    @response = @instance.get @space.wiki_name, @milestone.id
  end

  step 'I make request with method edit' do
    @response = @instance.edit @space.wiki_name, @milestone.id, milestone: { is_completed: true }
  end

  step 'I make request with method delete' do
    @response = @instance.delete @space.wiki_name, @milestone.id
  end

  %w{list all upcoming release_notes completed}.each do |method|
    step "I make request with method #{method}" do
      @response = @instance.send method, @space.wiki_name
    end
  end

  step 'I have a completed milestone' do
    create_milestone is_completed: true
  end

  step 'I have a milestone with release notes' do
    create_milestone release_notes: 'Very demanded features'
  end

  step 'I have "Assembla::Client::Spaces::Milestones" instance' do
    @instance = @milestones_api = Assembla::Client::Spaces::Milestones.new
  end

  step 'I use different space name' do
    @space_name = 'Milestones API'
  end
end
