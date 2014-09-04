# encoding: utf-8

module Assembla
  class Client::Activity < API
    VALID_REQUEST_PARAM_NAMES = %w[
      space_id
      to
      from
    ].freeze

    TIME_REGEXP = /^\d{4}-\d{2}-\d{2} \d{2}:\d{2}$/

    VALID_REQUEST_PARAM_VALUES = {
      'to' => TIME_REGEXP,
      'from' => TIME_REGEXP
    }

    def list(*args)
      arguments(args) do
        permit VALID_REQUEST_PARAM_NAMES
        assert_values VALID_REQUEST_PARAM_VALUES
      end

      response = get_request("/activity", arguments.params)
      return response unless block_given?
      response.each { |el| yield el }
    end

  end # Activity
end # Assembla
