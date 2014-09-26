module Assembla
  class Client::Spaces::Ssh::Actions::Launches < API

    # @example
    # api.spaces.ssh.actions.launches.list 'project1', 'action-id'
    def list(*args)
      arguments(args, required: [:space, :id])

      response = get_request("/spaces/#{arguments.space}/ssh/actions/#{arguments.id}/launches", arguments.params)
      return response unless block_given?
      response.each { |el| yield el }
    end
  end
end
