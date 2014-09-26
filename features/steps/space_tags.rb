class Spinach::Features::SpaceTags < Spinach::FeatureSteps
  include ApiTasks

  step 'I make request with method create' do
    i_have_a_tag
  end

  step 'I have a proposed tag' do
    @tag_state = 1
    i_have_a_tag
  end

  step 'I have a hidden tag' do
    @tag_state = 4
    i_have_a_tag
  end

  step 'I have a tag' do
    @tag_state ||= 2
    @tag = @response = @instance.create @space.wiki_name, tag: { name: 'Core', state: @tag_state }
    assert_created
  end

  step 'I have a ticket with tags' do
    create_ticket summary: 'With Tags', tags: %w{Core} + [ @tag.name ]
  end
  step 'I make request with method get' do
    @response = @instance.get @space.wiki_name, @tag.id
  end

  step 'I make request with method edit' do
    @response = @instance.edit @space.wiki_name, @tag.id, tag: { state: 1 }
  end

  step 'I make request with method delete' do
    @response = @instance.delete @space.wiki_name, @tag.id
  end

  step 'I make request with method list' do
    @response = @instance.list @space.wiki_name
  end

  step 'I make request with method active' do
    @response = @instance.active @space.wiki_name
  end

  step 'I make request with method proposed' do
    @response = @instance.proposed @space.wiki_name
  end

  step 'I make request with method hidden' do
    @response = @instance.hidden @space.wiki_name
  end

  step 'I make request with method tickets' do
    @response = @instance.tickets @space.wiki_name, @tag.id
  end

  step 'I have "Assembla::Client::Spaces::Tags" instance' do
    @instance = Assembla::Client::Spaces::Tags.new
  end

  step 'I use different space name' do
    @space_name = 'Tags API'
  end
end
