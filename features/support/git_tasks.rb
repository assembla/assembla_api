require "tmpdir"
require "git-ssh-wrapper"

module GitTasks
  include ApiTasks
  include Spinach::DSL

  def create_mr
    @mr_api ||= Assembla::Client::Spaces::SpaceTools::MergeRequests.new
    @mr = @response = @mr_api.create @space.wiki_name, @git_tool.id,
      merge_request: {
        source_symbol: 'i2014',
        target_symbol: 'master',
        title: 'Keep in mind'
      }
    assert_created
  end

  def git_tool_is_ready
    10.times do
      @git_url = @git_tool[:url]

      if @git_url.present?
        # adjust git url
        @git_url.sub!(':', ':22/')
        @git_url = 'ssh://' + @git_url

        break
      end

      @git_tool = @response = @tool_api.get @space.wiki_name, @git_tool.id
      the_response_status_should_be_200
      sleep 1
    end

    expect(@git_url).to be
  end

  KEY_FP = '35f62853c4899efdcd83b63a0b815a48'

  step 'I have a ssh key uploaded' do
    @key_api ||= Assembla::Client::Users::Keys.new
    found = false

    @key_api.list do |key|
      if key.finger_print == KEY_FP
        found = true
        break
      end
    end

    if !found
      @response = @key_api.create ssh_key: {title: 'Main test key', key: File.read(data_root.join 'api_test.pub')}
      assert_created
    end
  end

  step 'I have two git branches' do
    @git_dir = Dir.mktmpdir

    Dir.chdir @git_dir do
      run_cmd "tar --strip-components=1 -xzf #{data_root}/mr-sample.tar.gz"
      run_cmd "git remote add origin #{@git_url}"
      GitSSHWrapper.with_wrapper(:private_key_path => data_root.join('api_test')) do |wrapper|
        wrapper.set_env
        run_cmd "git push -q --all origin"
      end
    end
  end

  step 'I have a git tool' do
    @git_tool = create_tool 128
  end

  step 'I have a merge request' do
    create_mr
  end

end
