class Spinach::Features::WikiPages < Spinach::FeatureSteps
  include ApiTasks

  step 'I make request with method create' do
    i_have_a_wiki_page
  end

  step 'I make request with method get' do
    @response = @instance.get @space.wiki_name, @wiki.id
  end

  step 'I make request with method edit' do
    @response = @instance.edit @space.wiki_name, @wiki.id, wiki_page: { contents: 'ASAP' }
  end

  step 'I make request with method delete' do
    @response = @instance.delete @space.wiki_name, @wiki.id
  end

  step 'I have a child wiki page' do
    @parent_wiki = @wiki
    @wiki_params = { parent_id: @wiki.id, page_name: 'Software' }
    i_have_a_wiki_page
  end

  step 'I make request with method delete container' do
    @response = @instance.delete_parent @space.wiki_name, @parent_wiki.id
  end

  step 'I make request with method list' do
    @response = @instance.list @space.wiki_name
  end

  step 'I have "Assembla::Client::Spaces::WikiPages" instance' do
    @wiki_api = @instance = Assembla::Client::Spaces::WikiPages.new
  end

  step 'I use specific space name' do
    @space_name = 'Wiki API'
  end
end
