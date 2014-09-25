module Assembla
  class Client::Spaces::Ssh::Keys < API

    # @example
    # api.spaces.ssh.keys.generate 'project1'
    def generate(*args)
      arguments(args, required: [:space])
      post_request("/spaces/#{arguments.space}/ssh/generate_key", arguments.params)
    end

    # @example
    # api.spaces.ssh.keys.get 'project1'
    def get(*args)
      arguments(args, required: [:space])
      get_request("/spaces/#{arguments.space}/ssh/key", arguments.params)
    end
  end
end
