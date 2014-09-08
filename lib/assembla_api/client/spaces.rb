# encoding: utf-8

module Assembla
  class Client::Spaces < API
    # Load all the modules after initializing Repos to avoid superclass mismatch
    require_all 'assembla_api/client/spaces',
      'users'

    VALID_PARAMS_NAMES = %w[
      name
      wiki_name
      description
      public_permissions
      team_permissions
      watcher_permissions
      share_permissions
      status
    ].freeze

    # Access to Spaces::users API
    namespace :users

    #
    def my(*args)
      arguments(args)
      response = get_request("/spaces", arguments.params)
      return response unless block_given?
      response.each { |el| yield el }
    end

    # api.spaces.get space: 'breakout'
    def get(*args)
      arguments(args, required: [:space])
      get_request("/spaces/#{arguments.space}", arguments.params)
    end
    alias :find :get

    def create(*args)
      arguments(args) do
        permit VALID_PARAMS_NAMES
        assert_required %w[ name ]
      end

      params = arguments.params
      post_request("/spaces", params.merge_default({}))
    end

  end # Spaces
end # Assembla
