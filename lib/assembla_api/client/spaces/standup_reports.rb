module Assembla
  class Client::Spaces::StandupReports < API

    VALID_PARAMS_NAMES = %w[
      what_i_did
      what_i_will_do
      roadblocks
      filled_for
    ]

    # @example
    # api.spaces.standup_reports.create 'project1', standup_report: { what_i_will_do: 'Work on #400' }
    def create(*args)
      arguments(args, required: [:space]) do
        permit VALID_PARAMS_NAMES, recursive: true
      end

      post_request("/spaces/#{arguments.space}/standup_report", arguments.params)
    end
    alias :edit :create

    # @example
    # api.spaces.standup_reports.my 'project1'
    def my(*args)
      arguments(args, required: [:space]) do
        permit VALID_PARAMS_NAMES, recursive: true
      end

      get_request("/spaces/#{arguments.space}/standup_report", arguments.params)
    end

    # @example
    # api.spaces.standup_reports.list 'project1'
    def list(*args)
      arguments(args, required: [:space])
      response = get_request("/spaces/#{arguments.space}/standup_reports", arguments.params)
      return response unless block_given?
      response.each { |el| yield el }
    end
  end
end
