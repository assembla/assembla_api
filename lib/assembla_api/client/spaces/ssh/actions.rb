module Assembla
  class Client::Spaces::Ssh::Actions < API
    VALID_PARAMS_NAMES = %w[
      name
      command
      description
      frequency
      username
      position
      ssh_tool_server_id
    ].freeze

    VALID_REQUEST_PARAM_VALUES = {
      'frequency' => [ 0, 1, 2, 10, 11, 12 ],
      'name' => /^[a-zA-Z0-9 _]+$/
    }

    # @example
    # api.spaces.ssh.actions.create 'project1', ssh_action: { name: 'Stage' }
    def create(*args)
      arguments(args, required: [:space]) do
        permit VALID_PARAMS_NAMES, recursive: true
        assert_required %w[ name command username ]
        assert_values VALID_REQUEST_PARAM_VALUES
      end

      post_request("/spaces/#{arguments.space}/ssh/actions", arguments.params)
    end

    # @example
    # api.spaces.ssh.actions.get 'project1', 7
    def get(*args)
      arguments(args, required: [:space, :id])
      get_request("/spaces/#{arguments.space}/ssh/actions/#{arguments.id}", arguments.params)
    end

    # @example
    # api.spaces.ssh.actions.run 'project1', 7
    def run(*args)
      arguments(args, required: [:space, :id])
      get_request("/spaces/#{arguments.space}/ssh/actions/#{arguments.id}/run", arguments.params)
    end

    # @example
    # api.spaces.ssh.actions.edit 'project1', 7, ssh_action: { description: 'Do not deploy!' }
    def edit(*args)
      arguments(args, required: [:space, :id]) do
        permit VALID_PARAMS_NAMES , recursive: true
        assert_values VALID_REQUEST_PARAM_VALUES
      end

      put_request("/spaces/#{arguments.space}/ssh/actions/#{arguments.id}", arguments.params)
    end

    # Delete ssh action by ID
    # @example
    # api.spaces.ssh.actions.delete 'project1', 7
    def delete(*args)
      arguments(args, required: [:space, :id])
      delete_request("/spaces/#{arguments.space}/ssh/actions/#{arguments.id}", arguments.params)
    end

    # @example
    # api.spaces.ssh.actions.list 'project1'
    def list(*args)
      arguments(args, required: [:space])
      response = get_request("/spaces/#{arguments.space}/ssh/actions", arguments.params)
      return response unless block_given?
      response.each { |el| yield el }
    end
  end
end
