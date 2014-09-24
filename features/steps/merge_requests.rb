class Spinach::Features::MergeRequests < Spinach::FeatureSteps
  include GitTasks

  after do
    FileUtils.rm_rf @git_dir if @git_dir && File.exists?(@git_dir)
  end

  step 'I make request with method create' do
    i_have_a_merge_request
  end

  step 'I have a merge request' do
    create_mr
  end

  step 'I make request with method ignore' do
    @response = @instance.ignore @space.wiki_name, @git_tool.id, @mr.id
  end

  step 'I make request with method merge' do
    @response = @instance.merge @space.wiki_name, @git_tool.id, @mr.id
  end

  step 'I make request with method get' do
    @response = @instance.get @space.wiki_name, @git_tool.id, @mr.id
  end

  step 'I make request with method list' do
    @response = @instance.list @space.wiki_name, @git_tool.id
  end

  step 'I comment on MR' do
    # TODO needs MRV API
    pending 'step not implemented'
  end

  step 'I make request with method comments' do
    @response = @instance.comments @space.wiki_name, @git_tool.id, @mr.id
  end

  step 'I have a merge request with link to ticket' do
    # sample git repo has a commit with link to ticket
    create_mr
  end

  step 'I make request with method tickets' do
    @response = @instance.tickets @space.wiki_name, @git_tool.id, @mr.id
  end

  step 'I have "Assembla::Client::Spaces::SpaceTools::MergeRequests" instance' do
    @mr_api = @instance = Assembla::Client::Spaces::SpaceTools::MergeRequests.new
  end

  step 'I use specific space name' do
    @space_name = 'MR API'
  end
end
