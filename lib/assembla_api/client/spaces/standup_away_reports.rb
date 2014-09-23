module Assembla
  class Client::Spaces::StandupAwayReports < API

    VALID_PARAMS_NAMES = %w[
      what_i_did
      what_i_will_do
      roadblocks
      filled_for
    ]

    # @example
    # api.spaces.standup_away_reports.create 'project1', standup_report: { what_i_will_do: 'Work on #400' }
    def create(*args)
      arguments(args, required: [:space]) do
        permit VALID_PARAMS_NAMES, recursive: true
      end

      post_request("/spaces/#{arguments.space}/away_standup_report", arguments.params)
    end
    alias :edit :create

    # @example
    # api.spaces.standup_away_reports.my 'project1', date: '2014-09-09'
    def my(*args)
      arguments(args, required: [:space]) do
        permit VALID_PARAMS_NAMES + ['date'], recursive: true
      end

      get_request("/spaces/#{arguments.space}/away_standup_report", arguments.params)
    end

    # @example
    # api.spaces.standup_away_reports.list 'project1'
    def list(*args)
      arguments(args, required: [:space])
      response = get_request("/spaces/#{arguments.space}/away_standup_reports", arguments.params)
      return response unless block_given?
      response.each { |el| yield el }
    end
  end
end
