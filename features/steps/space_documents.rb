class Spinach::Features::SpaceDocuments < Spinach::FeatureSteps
  include ApiTasks

  step 'I make request with method create' do
    create_document
  end

  step 'I have a document' do
    create_document
  end

  def create_document
    @document = @response = @documents_api.create @space.wiki_name, document: {file: __FILE__ }
  end

  step 'I make request with method get' do
    @response = @instance.get @space.wiki_name, @document.id
  end

  step 'I make request with method download' do
    @response = @instance.download @space.wiki_name, @document.id
  end

  step 'I make request with method edit' do
    @response = @instance.edit @space.wiki_name, @document.id, document: { description: 'Was hard to obtain' }
  end

  step 'I make request with method delete' do
    @response = @instance.delete @space.wiki_name, @document.id
  end

  step 'I make request with method list' do
    @response = @instance.list @space.wiki_name
  end

  step 'I have "Assembla::Client::Spaces::Documents" instance' do
    @documents_api = @instance = Assembla::Client::Spaces::Documents.new
  end

  step 'I use specific space name' do
    @space_name = "Docs API"
  end

  step 'I have a files tool' do
    create_tool 18
  end
end
