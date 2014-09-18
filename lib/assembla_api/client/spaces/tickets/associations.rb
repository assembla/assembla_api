module Assembla
  class Client::Spaces::Tickets::Associations < API
    VALID_PARAMS_NAMES = %w{ ticket2_id relationship }
    VALID_REQUEST_PARAM_VALUES = {
      'relationship' => 0..8,
    }

    # @example
    # api.spaces.tickets.associations.create 'project1', 500,
    #      ticket_association: { ticket2_id: 125, relationship: 6 }
    def create(*args)
      arguments(args, required: [:space, :number]) do
        permit VALID_PARAMS_NAMES, recursive: true
        assert_required %w[ ticket2_id ]
        assert_values VALID_REQUEST_PARAM_VALUES
      end

      post_request("/spaces/#{arguments.space}/tickets/#{arguments.number}/ticket_associations", arguments.params)
    end

    # @example
    # api.spaces.tickets.associations.get 'project1', 500, 123
    def get(*args)
      arguments(args, required: [:space, :number, :id])
      get_request("/spaces/#{arguments.space}/tickets/#{arguments.number}/ticket_associations/#{arguments.id}", arguments.params)
    end

    # @example
    # api.spaces.tickets.associations.edit 'project1', 500, 123, ticket_association: {relationship: 3}
    def edit(*args)
      arguments(args, required: [:space, :number, :id]) do
        permit VALID_PARAMS_NAMES - ['ticket2_id'] , recursive: true
        assert_required %w[ relationship ]
        assert_values VALID_REQUEST_PARAM_VALUES
      end

      put_request("/spaces/#{arguments.space}/tickets/#{arguments.number}/ticket_associations/#{arguments.id}", arguments.params)
    end

    # Delete ticket association by ID
    # @example
    # api.spaces.tickets.associations.delete 'project1', 500, 123
    def delete(*args)
      arguments(args, required: [:space, :number, :id])
      delete_request("/spaces/#{arguments.space}/tickets/#{arguments.number}/ticket_associations/#{arguments.id}", arguments.params)
    end

    # @example
    # api.spaces.tickets.associations.list 'project1', 500
    def list(*args)
      arguments(args, required: [:space, :number])
      response = get_request("/spaces/#{arguments.space}/tickets/#{arguments.number}/ticket_associations", arguments.params)
      return response unless block_given?
      response.each { |el| yield el }
    end
  end
end
