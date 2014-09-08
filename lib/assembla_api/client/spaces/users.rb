module Assembla
  class Client::Spaces::Users < API
    # api.spaces.users.list space: 'project1'
    def list(*args)
      arguments(args, required: [:space])
      response = get_request("/spaces/#{arguments.space}/users", arguments.params)
      return response unless block_given?
      response.each { |el| yield el }
    end
  end
end
