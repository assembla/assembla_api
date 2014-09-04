# encoding: utf-8

module Assembla
  class Client::PullRequests < API

    require_all 'assembla_api/client/pull_requests',
      'comments'

    VALID_REQUEST_PARAM_NAMES = %w[
      title
      body
      base
      head
      state
      issue
      commit_message
      mime_type
      resource
    ].freeze

    VALID_REQUEST_PARAM_VALUES = {
      'state' => %w[ open closed ]
    }

    # Access to PullRequests::Comments API
    namespace :comments

    # List pull requests
    #
    # @example
    #  assembla = Assembla.new user: 'user-name', repo: 'repo-name'
    #  assembla.pull_requests.list
    #  assembla.pull_requests.list { |req| ... }
    #
    # @example
    #  pulls = Assembla::PullRequests.new
    #  pulls.pull_requests.list 'user-name', 'repo-name'
    #
    # @api public
    def list(*args)
      arguments(args, required: [:user, :repo]) do
        permit VALID_REQUEST_PARAM_NAMES
        assert_values VALID_REQUEST_PARAM_VALUES
      end

      response = get_request("/repos/#{arguments.user}/#{arguments.repo}/pulls", arguments.params)
      return response unless block_given?
      response.each { |el| yield el }
    end
    alias :all :list

    # Get a single pull request
    #
    # = Examples
    #  assembla = Assembla.new
    #  assembla.pull_requests.get 'user-name', 'repo-name', 'number'
    #
    #  pulls = Assembla::PullRequests.new
    #  pulls.get 'user-name', 'repo-name', 'number'
    #
    def get(*args)
      arguments(args, required: [:user, :repo, :number])

      get_request("/repos/#{arguments.user}/#{arguments.repo}/pulls/#{arguments.number}", arguments.params)
    end
    alias :find :get

    # Create a pull request
    #
    # @param [Hash] params
    # @option params [String] :title 
    #   Required string
    # @option params [String] :body
    #   Optional string
    # @option params [String] :base
    #   Required string - The branch you want your changes pulled into.
    # @option params [String] :head
    #   Required string - The branch where your changes are implemented.
    #
    # @note: head and base can be either a sha or a branch name.
    # Typically you would namespace head with a user like this: username:branch.
    #
    # Alternative Input
    # You can also create a Pull Request from an existing Issue by passing
    # an Issue number instead of <tt>title</tt> and <tt>body</tt>.
    # @option params [Numeric] :issue
    #   Required number - Issue number in this repository to turn into a Pull Request.
    #
    # @example
    #  assembla = Assembla.new oauth_token: '...'
    #  assembla.pull_requests.create 'user-name', 'repo-name',
    #    title: "Amazing new feature",
    #    body: "Please pull this in!",
    #    head: "buildbot:new-feature",
    #    base: "master"
    #
    # @example
    #  assembla.pull_requests.create 'user-name', 'repo-name',
    #    issue: "5",
    #    head: "buildbot:new-feature",
    #    base: "master"
    #
    # @api public
    def create(*args)
      arguments(args, required: [:user, :repo]) do
        permit VALID_REQUEST_PARAM_NAMES
      end

      post_request("/repos/#{arguments.user}/#{arguments.repo}/pulls", arguments.params)
    end

    # Update a pull request
    #
    # @param [Hash] params
    # @option params [String] :title
    #   Optional string
    # @optoin params [String] :body
    #   Optional string
    # @option params [String] :state
    #   Optional string - State of this Pull Request.
    #   Valid values are open and closed.
    #
    # @example
    #  assembla = Assembla.new oauth_token: '...'
    #  assembla.pull_requests.update 'user-name', 'repo-name', 'number'
    #    title: "Amazing new title",
    #    body: "Update body",
    #    state: "open"
    #
    # @api public
    def update(*args)
      arguments(args, required: [:user, :repo, :number]) do
        permit VALID_REQUEST_PARAM_NAMES
        assert_values VALID_REQUEST_PARAM_VALUES
      end

      patch_request("/repos/#{arguments.user}/#{arguments.repo}/pulls/#{arguments.number}", arguments.params)
    end

    # List commits on a pull request
    #
    # @example
    #  assembla = Assembla.new
    #  assembla.pull_requests.commits 'user-name', 'repo-name', 'number'
    #
    # @api public
    def commits(*args)
      arguments(args, required: [:user, :repo, :number])

      response = get_request("/repos/#{arguments.user}/#{arguments.repo}/pulls/#{arguments.number}/commits", arguments.params)
      return response unless block_given?
      response.each { |el| yield el }
    end

    # List pull requests files
    #
    # @example
    #  assembla = Assembla.new
    #  assembla.pull_requests.files 'user-name', 'repo-name', 'number'
    #
    # @api public
    def files(*args)
      arguments(args, required: [:user, :repo, :number])

      response = get_request("/repos/#{arguments.user}/#{arguments.repo}/pulls/#{arguments.number}/files", arguments.params)
      return response unless block_given?
      response.each { |el| yield el }
    end

    # Check if pull request has been merged
    #
    # @example
    #  assembla = Assembla.new
    #  assembla.pull_requests.merged? 'user-name', 'repo-name', 'number'
    #
    # @api public
    def merged?(*args)
      arguments(args, required: [:user, :repo, :number])

      get_request("/repos/#{arguments.user}/#{arguments.repo}/pulls/#{arguments.number}/merge", arguments.params)
      true
    rescue Assembla::Error::NotFound
      false
    end

    # Merge a pull request(Merge Button)
    #
    # @param [Hash] params
    # @option params [String] :commit_message
    #   Optional string - The message that will be used for the merge commit
    #
    # @example
    #  assembla = Assembla.new
    #  assembla.pull_requests.merge 'user-name', 'repo-name', 'number'
    #
    # @api public
    def merge(*args)
      arguments(args, required: [:user, :repo, :number]) do
        permit VALID_REQUEST_PARAM_NAMES
      end

      put_request("/repos/#{arguments.user}/#{arguments.repo}/pulls/#{arguments.number}/merge", arguments.params)
    end
  end # PullRequests
end # Assembla
