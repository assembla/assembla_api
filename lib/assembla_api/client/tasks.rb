module Assembla
  class Client::Tasks < API
    VALID_PARAMS_NAMES = %w{
      description
      job_agreement_id
      space_id
      ticket_id
      url
      hours
      begin_at
      end_at
    }

    # @example
    # api.tasks.get 963
    def get(*args)
      arguments(args, required: [:id])
      get_request("/tasks/#{arguments.id}", arguments.params)
    end
    alias :find :get

    def create(*args)
      arguments(args) do
        permit VALID_PARAMS_NAMES, recursive: true
        assert_required %w[ description space_id ]
      end

      task = arguments.params['user_task'] = arguments.params.delete 'task'
      task['begin_at'] ||= Time.now.utc.strftime '%FT%TZ'
      task['hours'] ||= 1

      post_request("/tasks", arguments.params)
    end

    def delete(*args)
      arguments(args, required: [:id])
      delete_request("/tasks/#{arguments.id}", arguments.params)
    end
    alias :remove :delete

    # Edit a task
    #
    # @param [Hash] params
    # @option params [String] :description
    #   Optional string
    #
    # @example
    #  api = Assembla.new
    #  api.tasks.edit 963, task: {
    #    url: 'http://google.com',
    #    description: 'Search using new engine'
    #  }
    def edit(*args)
      arguments(args, required: [:id]) do
        permit VALID_PARAMS_NAMES, recursive: true
      end

      arguments.params['user_task'] = arguments.params.delete 'task'

      put_request("/tasks/#{arguments.id}", arguments.params)
    end

    # @example
    # api.tasks.list
    def list(*args)
      arguments(args)
      response = get_request("/tasks", arguments.params)
      return response unless block_given?
      response.each { |el| yield el }
    end
  end
end
