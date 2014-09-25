class Spinach::Features::WikiPagesVersions < Spinach::FeatureSteps
  include ApiTasks

  step 'I make request with method get' do
    @response = @instance.get @space.wiki_name, @wiki.id, @wiki_version.id
  end

  step 'I make request with method list' do
    @response = @instance.list @space.wiki_name, @wiki.id
  end

  step 'I know first version ID' do
    i_make_request_with_method_list
    expect(@response.size).to eq 1
    @wiki_version = @response.first
  end

  step 'I have "Assembla::Client::Spaces::WikiPages::Versions" instance' do
    @instance = Assembla::Client::Spaces::WikiPages::Versions.new
  end

  step 'I use specific space name' do
    @space_name = 'Wiki page versions API'
  end
end
