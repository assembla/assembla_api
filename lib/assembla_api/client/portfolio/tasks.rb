module Assembla
  class Client::Portfolio::Tasks < API

    # @example
    # api.portfolio.tasks.list
    def list(*args)
      arguments(args)
      response = get_request("/tasks", arguments.params)
      return response unless block_given?
      response.each { |el| yield el }
    end
  end
end
