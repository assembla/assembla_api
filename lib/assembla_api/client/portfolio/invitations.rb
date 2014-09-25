module Assembla
  class Client::Portfolio::Invitations < API

    # @example
    # api.portfolio.invitations.list
    def list(*args)
      arguments(args)
      response = get_request("/invitations", arguments.params)
      return response unless block_given?
      response.each { |el| yield el }
    end

    # @example
    # api.portfolio.invitations.create
    def create(*args)
      arguments(args) do
        permit %w{ role title identifiers }, recursive: true
      end

      post_request("/invitations", arguments.params)
    end

    # @example
    # api.portfolio.invitations.get 187
    def get(*args)
      arguments(args, required: [:id])
      get_request("/invitations/#{arguments.id}", arguments.params)
    end
  end
end
