# encoding: utf-8

module Assembla
  class Client::Spaces < API
    # Load all the modules after initializing Repos to avoid superclass mismatch
    require_all 'assembla_api/client/spaces',
      'space_tools',
      'tickets',
      'user_roles',
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
      team_tab_role
      default_showpage
      tabs_order
      banner
      banner_height
      banner_text
      banner_link
      style
      approved
      can_join
      wiki_format
    ].freeze

    VALID_REQUEST_PARAM_VALUES = {
      'status' => [0, 1, 2, 3, 4],
      'team_tab_role' => [0, 10, 50, 90],
      'public_permissions' => [0, 1],
      'team_permissions' => [1, 2, 3],
      'watcher_permissions' => [0, 1],
    }

    # Access to Spaces::Users API
    namespace :users

    # Access to Spaces::UserRoles API
    namespace :user_roles

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
        assert_values VALID_REQUEST_PARAM_VALUES
      end

      post_request("/spaces", arguments.params)
    end

    def copy(*args)
      arguments(args, required: [:space]) do
        permit VALID_PARAMS_NAMES
        assert_required %w[ name ]
        assert_values VALID_REQUEST_PARAM_VALUES
      end

      post_request("/spaces/#{arguments.space}/copy", arguments.params)
    end

    # Delete a space
    #
    # Deleting a space requires owner access.
    #
    # @example
    #  assembla = Assembla.new oauth_token: '...'
    #  assembla.repos.delete 'space-name'
    #
    # @api public
    def delete(*args)
      arguments(args, required: [:space])
      delete_request("/spaces/#{arguments.space}", arguments.params)
    end
    alias :remove :delete

    # Edit a space
    #
    # @param [Hash] params
    # @option params [String] :name
    #   Required string
    # @option params [String] :description
    #   Optional string
    #
    # @example
    #  assembla = Assembla.new
    #  assembla.spaces.edit 'space-name',
    #    name: 'hello-world',
    #    description: 'This is your first space'
    #
    def edit(*args)
      arguments(args,required: [:space]) do
        permit VALID_PARAMS_NAMES
        assert_values VALID_REQUEST_PARAM_VALUES
      end

      put_request("/spaces/#{arguments.space}", arguments.params)
    end
  end # Spaces
end # Assembla
