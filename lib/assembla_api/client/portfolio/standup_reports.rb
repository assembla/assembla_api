module Assembla
  class Client::Portfolio::StandupReports < API

    # @example
    # api.portfolio.standup_reports.list
    def list(*args)
      arguments(args)
      response = get_request("/standup_reports", arguments.params)
      return response unless block_given?
      response.each { |el| yield el }
    end

    # @example
    # api.portfolio.standup_reports.away
    def away(*args)
      arguments(args) do
        permit %w{ from to }
      end

      response = get_request("/standup_reports/away", arguments.params)
      return response unless block_given?
      response.each { |el| yield el }
    end

    # @example
    # api.portfolio.standup_reports.with_needs
    def with_needs(*args)
      arguments(args)
      response = get_request("/standup_reports/with_needs", arguments.params)
      return response unless block_given?
      response.each { |el| yield el }
    end
  end
end
