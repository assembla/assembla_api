class Spinach::Features::MrVersionsVotes < Spinach::FeatureSteps
  include GitTasks

  def vote
    @mr_vote = @response = @instance.up @space.wiki_name, @git_tool.id, @mr.id, 1
    assert_created
  end

  step 'I voted already' do
    vote
  end

  step 'I make request with method list' do
    @response = @instance.list @space.wiki_name, @git_tool.id, @mr.id, 1
  end

  step 'I make request with method upvote' do
    vote
  end

  step 'I make request with method downvote' do
    @response = @instance.down @space.wiki_name, @git_tool.id, @mr.id, 1
  end

  step 'I make request with method delete' do
    @response = @instance.delete @space.wiki_name, @git_tool.id, @mr.id, 1
  end

  step 'I have "Assembla::Client::Spaces::SpaceTools::MergeRequests::Versions::Votes" instance' do
    @instance = Assembla::Client::Spaces::SpaceTools::MergeRequests::Versions::Votes.new
  end

  step 'I use specific space name' do
    @space_name = 'MRV votes API'
  end
end
