module Assembla
  class Client::Spaces::Tickets::Comments < API
    VALID_PARAMS_NAMES = %w{ user_id comment created_on }

    # @example
    # api.spaces.tickets.comments.create 'project1', 500,
    #      ticket_comment: { comment: 'I will do it now' }
    def create(*args)
      arguments(args, required: [:space, :number]) do
        permit VALID_PARAMS_NAMES, recursive: true
        assert_required %w[ comment ]
      end

      post_request("/spaces/#{arguments.space}/tickets/#{arguments.number}/ticket_comments", arguments.params)
    end

    # @example
    # api.spaces.tickets.comments.get 'project1', 500, 142857
    def get(*args)
      arguments(args, required: [:space, :number, :id])
      get_request("/spaces/#{arguments.space}/tickets/#{arguments.number}/ticket_comments/#{arguments.id}", arguments.params)
    end

    # @example
    # api.spaces.tickets.comments.edit 'project1', 500, 142857,
    #   ticket_comment: {  comment: 'Ops, I made a typo' }
    def edit(*args)
      arguments(args, required: [:space, :number, :id]) do
        permit ['comment'] , recursive: true
        assert_required %w[ comment ]
      end

      put_request("/spaces/#{arguments.space}/tickets/#{arguments.number}/ticket_comments/#{arguments.id}", arguments.params)
    end

    # @example
    # api.spaces.tickets.comments.list 'project1', 500
    def list(*args)
      arguments(args, required: [:space, :number])
      response = get_request("/spaces/#{arguments.space}/tickets/#{arguments.number}/ticket_comments", arguments.params)
      return response unless block_given?
      response.each { |el| yield el }
    end
  end
end
