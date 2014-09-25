module Assembla
  class Client::Portfolio::Spaces < API

    # @example
    # api.portfolio.spaces.list
    def list(*args)
      arguments(args)
      response = get_request("/spaces", arguments.params)
      return response unless block_given?
      response.each { |el| yield el }
    end
  end
end
