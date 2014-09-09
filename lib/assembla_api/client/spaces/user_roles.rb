module Assembla
  class Client::Spaces::UserRoles < API

    VALID_PARAMS_NAMES = %w[
      user_id
      role
      title
      message
    ].freeze

    VALID_REQUEST_PARAM_VALUES = {
      'role' => %w{watcher member owner},
    }

    # api.spaces.user_roles.list 'project1'
    def list(*args)
      arguments(args, required: [:space])
      response = get_request("/spaces/#{arguments.space}/user_roles", arguments.params)
      return response unless block_given?
      response.each { |el| yield el }
    end

    # api.spaces.user_roles.create 'project1', user_role: {user_id: UID, role: 'member'}
    def create(*args)
      arguments(args, required: [:space]) do
        permit VALID_PARAMS_NAMES, recursive: true
        assert_required %w[ user_id role ]
        assert_values VALID_REQUEST_PARAM_VALUES
      end

      post_request("/spaces/#{arguments.space}/user_roles", arguments.params)
    end
  end # UserRoles
end # Assembla
