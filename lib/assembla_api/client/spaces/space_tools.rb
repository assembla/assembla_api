module Assembla
  class Client::Spaces::SpaceTools < API
    require_all 'assembla_api/client/spaces/space_tools',
      'merge_requests'

    namespace :merge_requests

    VALID_PARAMS_NAMES = %w{
      team_permissions
      watcher_permissions
      public_permissions
    }

    # @example
    # api.spaces.space_tools.create 'project1', 21,
    def create(*args)
      arguments(args, required: [:space, :tool_id])
      post_request("/spaces/#{arguments.space}/space_tools/#{arguments.tool_id}/add")
    end

    # @example
    # api.spaces.space_tools.edit 'project1', 'tool_guid', space_tool: {watcher_permissions: 1}
    def edit(*args)
      arguments(args, required: [:space, :space_tool_id]) do
        permit VALID_PARAMS_NAMES, recursive: true
      end

      put_request("/spaces/#{arguments.space}/space_tools/#{arguments.space_tool_id}", arguments.params)
    end

    # @example
    # api.spaces.space_tools.get 'project1', 'tool_guid'
    def get(*args)
      arguments(args, required: [:space, :space_tool_id])
      get_request("/spaces/#{arguments.space}/space_tools/#{arguments.space_tool_id}")
    end

    # @example
    # api.spaces.space_tools.delete 'project1', 'tool_guid'
    def delete(*args)
      arguments(args, required: [:space, :space_tool_id])
      delete_request("/spaces/#{arguments.space}/space_tools/#{arguments.space_tool_id}")
    end

    # @example
    # api.spaces.space_tools.list 'project1'
    # api.spaces.space_tools.all 'project1'
    def list(*args)
      arguments(args, required: [:space])
      response = get_request("/spaces/#{arguments.space}/space_tools", arguments.params)
      return response unless block_given?
      response.each { |el| yield el }
    end
    alias :all :list

    # @example
    # api.spaces.space_tools.repo_list 'project1'
    def repo_list(*args)
      arguments(args, required: [:space])
      response = get_request("/spaces/#{arguments.space}/space_tools/repo", arguments.params)
      return response unless block_given?
      response.each { |el| yield el }
    end
  end # SpaceTools
end # Assembla
