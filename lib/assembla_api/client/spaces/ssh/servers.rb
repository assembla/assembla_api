module Assembla
  class Client::Spaces::Ssh::Servers < API
    VALID_PARAMS_NAMES = %w[
      name
      remote_port
      remote_host
      description
    ].freeze

    VALID_REQUEST_PARAM_VALUES = {
      'name' => /^[a-zA-Z0-9 _]+$/
    }

    # @example
    # api.spaces.ssh.servers.create 'project1', ssh_server: { name: 'Stage' }
    def create(*args)
      arguments(args, required: [:space]) do
        permit VALID_PARAMS_NAMES, recursive: true
        assert_required %w[ remote_host name ]
        assert_values VALID_REQUEST_PARAM_VALUES
      end

      arguments.params['ssh_server']['remote_port'] ||= 22

      post_request("/spaces/#{arguments.space}/ssh/servers", arguments.params)
    end

    # @example
    # api.spaces.ssh.servers.get 'project1', 7
    def get(*args)
      arguments(args, required: [:space, :id])
      get_request("/spaces/#{arguments.space}/ssh/servers/#{arguments.id}", arguments.params)
    end

    # @example
    # api.spaces.ssh.servers.edit 'project1', 7, ssh_server: { description: 'Do not deploy!' }
    def edit(*args)
      arguments(args, required: [:space, :id]) do
        permit VALID_PARAMS_NAMES , recursive: true
        assert_values VALID_REQUEST_PARAM_VALUES
      end

      put_request("/spaces/#{arguments.space}/ssh/servers/#{arguments.id}", arguments.params)
    end

    # Delete ssh server by ID
    # @example
    # api.spaces.ssh.servers.delete 'project1', 7
    def delete(*args)
      arguments(args, required: [:space, :id])
      delete_request("/spaces/#{arguments.space}/ssh/servers/#{arguments.id}", arguments.params)
    end

    # @example
    # api.spaces.ssh.servers.list 'project1'
    def list(*args)
      arguments(args, required: [:space])
      response = get_request("/spaces/#{arguments.space}/ssh/servers", arguments.params)
      return response unless block_given?
      response.each { |el| yield el }
    end
  end
end
