module Assembla
  class Client::Spaces::SpaceTools::MergeRequests < API
    require_all 'assembla_api/client/spaces/space_tools/merge_requests',
      'versions'

    namespace :versions
    namespace :votes

    VALID_PARAMS_NAMES = %w{
      description
      source_cleanup
      source_symbol
      target_space_tool_id
      target_symbol
      title
    }

    VALID_REQUEST_PARAM_VALUES = {
      'source_cleanup' => [0, 1]
    }

    # @example
    # api.spaces.space_tools.merge_requests.create 'project1', 'git',
    #   merge_request: { title: 'Mobile App V2' }
    def create(*args)
      arguments(args, required: [:space, :space_tool]) do
        permit VALID_PARAMS_NAMES, recursive: true
        assert_required %w[ title source_symbol target_symbol ]
        assert_values VALID_REQUEST_PARAM_VALUES
      end

      post_request api_uri(arguments), arguments.params
    end

    # @example
    # api.spaces.space_tools.merge_requests.get 'project1', 'git', 7
    def get(*args)
      arguments(args, required: [:space, :space_tool, :id])
      get_request api_uri(arguments), arguments.params
    end

    # @example
    # api.spaces.space_tools.merge_requests.edit 'project1', 'git', 7,
    #   merge_request: { description: 'in-production #tickets' }
    def edit(*args)
      arguments(args, required: [:space, :space_tool, :id]) do
        permit VALID_PARAMS_NAMES , recursive: true
        assert_values VALID_REQUEST_PARAM_VALUES
      end

      put_request api_uri(arguments), arguments.params
    end

    # Ignore merge request by ID
    # @example
    # api.spaces.space_tools.merge_requests.ignore 'project1', 'git', 7
    def ignore(*args)
      arguments(args, required: [:space, :space_tool, :id])
      put_request api_uri(arguments, :ignore), arguments.params
    end

    # Merge MR by ID
    # @example
    # api.spaces.space_tools.merge_requests.merge 'project1', 'git', 7
    def merge(*args)
      arguments(args, required: [:space, :space_tool, :id])
      put_request api_uri(arguments, :merge_and_close), arguments.params
    end

    # @example
    # api.spaces.space_tools.space_tools.merge_requests.list 'project1', 'git'
    def list(*args)
      arguments(args, required: [:space, :space_tool])
      response = get_request api_uri(arguments), arguments.params
      return response unless block_given?
      response.each { |el| yield el }
    end

    # @example
    # api.spaces.space_tools.space_tools.merge_requests.tickets 'project1', 'git', 7
    def tickets(*args)
      arguments(args, required: [:space, :space_tool, :id])
      response = get_request api_uri(arguments, :tickets), arguments.params
      return response unless block_given?
      response.each { |el| yield el }
    end

    # @example
    # api.spaces.space_tools.space_tools.merge_requests.comments 'project1', 'git', 7
    def comments(*args)
      arguments(args, required: [:space, :space_tool, :id])
      response = get_request api_uri(arguments, :comments), arguments.params
      return response unless block_given?
      response.each { |el| yield el }
    end

    private
    def api_uri(arguments, method = nil)
      uri = "/spaces/#{arguments.space}/space_tools/#{arguments.space_tool}/merge_requests"
      uri += "/" + arguments['id'].to_s if arguments['id']
      uri += "/" + method.to_s if method
      uri
    end
  end
end
