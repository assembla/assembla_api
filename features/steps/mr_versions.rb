class Spinach::Features::MrVersions < Spinach::FeatureSteps
  include GitTasks

  step 'I make request with method list' do
    @response = @instance.list @space.wiki_name, @git_tool.id, @mr.id
  end

  step 'I make request with method get' do
    @response = @instance.get @space.wiki_name, @git_tool.id, @mr.id, 1
  end

  step 'I push new changes to a dev branch' do
    Dir.chdir @git_dir do
      GitSSHWrapper.with_wrapper(:private_key_path => data_root.join('api_test')) do |wrapper|
        wrapper.set_env
        run_cmd "git push -q origin i2014a:i2014"
      end
    end
  end

  step 'I make request with method create' do
    @response = @instance.create @space.wiki_name, @git_tool.id, @mr.id
  end

  step 'I have "Assembla::Client::Spaces::SpaceTools::MergeRequests::Versions" instance' do
    @instance = Assembla::Client::Spaces::SpaceTools::MergeRequests::Versions.new
  end

  step 'I use specific space name' do
    @space_name = 'MRV'# + Time.now.strftime('%Y%m%d %H%M')
  end
end
