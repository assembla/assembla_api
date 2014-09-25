module Assembla
  class Client::Portfolio::TicketReports < API

    # @example
    # api.portfolio.ticket_reports.list
    def list(*args)
      arguments(args)
      response = get_request("/ticket_reports", arguments.params)
      return response unless block_given?
      response.each { |el| yield el }
    end
  end
end
