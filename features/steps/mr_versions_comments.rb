class Spinach::Features::MrVersionsComments < Spinach::FeatureSteps
  include GitTasks

  step 'I make request with method create' do
    create_mr_comment
  end

  step 'I have a merge request version comment' do
    create_mr_comment
    assert_created
  end

  step 'I make request with method list' do
    @response = @instance.list @space.wiki_name, @git_tool.id, @mr.id, 1
  end

  step 'I have "Assembla::Client::Spaces::SpaceTools::MergeRequests::Versions::Comments" instance' do
    @mr_comments_api = @instance = Assembla::Client::Spaces::SpaceTools::MergeRequests::Versions::Comments.new
  end

  step 'I use specific space name' do
    @space_name = 'MRV comments API'
  end
end
