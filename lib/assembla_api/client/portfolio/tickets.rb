module Assembla
  class Client::Portfolio::Tickets < API

    # @example
    # api.portfolio.tickets.list
    def list(*args)
      arguments(args)
      response = get_request("/tickets", arguments.params)
      return response unless block_given?
      response.each { |el| yield el }
    end
  end
end
