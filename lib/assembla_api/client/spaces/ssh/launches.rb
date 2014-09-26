module Assembla
  class Client::Spaces::Ssh::Launches < API

    # @example
    # api.spaces.ssh.launches.list 'project1'
    def list(*args)
      arguments(args, required: [:space])

      response = get_request("/spaces/#{arguments.space}/ssh/launches", arguments.params)
      return response unless block_given?
      response.each { |el| yield el }
    end

    # @example
    # api.spaces.ssh.launches.get 'project1', 142
    def get(*args)
      arguments(args, required: [:space, :id])
      get_request("/spaces/#{arguments.space}/ssh/launches/#{arguments.id}", arguments.params)
    end

    # Get full output of the command
    # @example
    # api.spaces.ssh.launches.output 'project1', 142
    def output(*args)
      arguments(args, required: [:space, :id])
      get_request("/spaces/#{arguments.space}/ssh/launches/#{arguments.id}/output", arguments.params)
    end
  end
end
