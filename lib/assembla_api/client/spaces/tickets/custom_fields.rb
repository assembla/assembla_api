module Assembla
  class Client::Spaces::Tickets::CustomFields < API
    VALID_PARAMS_NAMES = %w{type title order required hide default_value list_options}
    VALID_REQUEST_PARAM_VALUES = {
      'type' => %w{text numeric team\ list list date},
      'required' => [true, false],
      'hide' => [true, false]
    }

    # @example
    # api.spaces.tickets.custom_fields.create 'project1', custom_field: { title: 'Build' }
    def create(*args)
      arguments(args, required: [:space]) do
        permit VALID_PARAMS_NAMES, recursive: true
        assert_required %w[ title ]
        assert_values VALID_REQUEST_PARAM_VALUES
      end

      post_request("/spaces/#{arguments.space}/tickets/custom_fields", arguments.params)
    end

    # @example
    # api.spaces.tickets.custom_fields.get 'project1', 34
    def get(*args)
      arguments(args, required: [:space, :id])
      get_request("/spaces/#{arguments.space}/tickets/custom_fields/#{arguments.id}", arguments.params)
    end

    # @example
    # api.spaces.tickets.custom_fields.edit 'project1', 34, custom_field: {title: 'Build Number', type: 'numeric'}
    def edit(*args)
      arguments(args, required: [:space, :id]) do
        permit VALID_PARAMS_NAMES , recursive: true
        assert_values VALID_REQUEST_PARAM_VALUES
      end

      put_request("/spaces/#{arguments.space}/tickets/custom_fields/#{arguments.id}", arguments.params)
    end

    # Delete ticket status by ID
    # @example
    # api.spaces.tickets.custom_fields.delete 'project1', 34
    def delete(*args)
      arguments(args, required: [:space, :id])
      delete_request("/spaces/#{arguments.space}/tickets/custom_fields/#{arguments.id}", arguments.params)
    end

    # @example
    # api.spaces.tickets.custom_fields.list 'project1'
    def list(*args)
      arguments(args, required: [:space])
      response = get_request("/spaces/#{arguments.space}/tickets/custom_fields", arguments.params)
      return response unless block_given?
      response.each { |el| yield el }
    end
  end
end
