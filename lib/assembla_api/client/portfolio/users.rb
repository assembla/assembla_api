module Assembla
  class Client::Portfolio::Users < API

    # @example
    # api.portfolio.tasks.list
    def list(*args)
      arguments(args)
      response = get_request("/users", arguments.params)
      return response unless block_given?
      response.each { |el| yield el }
    end
  end
end
