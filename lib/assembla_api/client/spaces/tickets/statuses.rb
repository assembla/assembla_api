module Assembla
  class Client::Spaces::Tickets::Statuses < API
    VALID_PARAMS_NAMES = %w{name state list_order}
    VALID_REQUEST_PARAM_VALUES = {
      'state' => [0, 1]
    }

    # @example
    # api.spaces.tickets.statuses.create 'project1', status: { name: 'Review' }
    def create(*args)
      arguments(args, required: [:space]) do
        permit VALID_PARAMS_NAMES, recursive: true
        assert_required %w[ name ]
        assert_values VALID_REQUEST_PARAM_VALUES
      end

      post_request("/spaces/#{arguments.space}/tickets/statuses", arguments.params)
    end

    # @example
    # api.spaces.tickets.statuses.get 'project1', 34
    def get(*args)
      arguments(args, required: [:space, :id])
      get_request("/spaces/#{arguments.space}/tickets/statuses/#{arguments.id}", arguments.params)
    end

    # @example
    # api.spaces.tickets.statuses.edit 'project1', 34, status: {name: 'Review Design'}
    def edit(*args)
      arguments(args, required: [:space, :id]) do
        permit VALID_PARAMS_NAMES , recursive: true
        assert_values VALID_REQUEST_PARAM_VALUES
      end

      put_request("/spaces/#{arguments.space}/tickets/statuses/#{arguments.id}", arguments.params)
    end

    # Delete ticket status by ID
    # @example
    # api.spaces.tickets.statuses.delete 'project1', 34
    def delete(*args)
      arguments(args, required: [:space, :id])
      delete_request("/spaces/#{arguments.space}/tickets/statuses/#{arguments.id}", arguments.params)
    end

    # @example
    # api.spaces.tickets.statuses.list 'project1'
    def list(*args)
      arguments(args, required: [:space])
      response = get_request("/spaces/#{arguments.space}/tickets/statuses", arguments.params)
      return response unless block_given?
      response.each { |el| yield el }
    end
  end
end
