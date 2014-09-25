module Assembla
  class Client::Spaces::SpaceTools::MergeRequests::Versions < API
    require_all 'assembla_api/client/spaces/space_tools/merge_requests/versions',
      'votes',
      'comments'

    namespace :comments

    # @example
    # api.spaces.space_tools.merge_requests.versions.create 'project1', 'git', 7
    def create(*args)
      arguments(args, required: [:space, :space_tool, :mr_id])

      post_request api_uri(arguments), arguments.params
    end

    # @example
    # api.spaces.space_tools.merge_requests.versions.get 'project1', 'git', 7, 571
    def get(*args)
      arguments(args, required: [:space, :space_tool, :mr_id, :id])
      get_request api_uri(arguments), arguments.params
    end

    # @example
    # api.spaces.space_tools.space_tools.merge_requests.versions.list 'project1', 'git', 571
    def list(*args)
      arguments(args, required: [:space, :space_tool, :mr_id])
      response = get_request api_uri(arguments), arguments.params
      return response unless block_given?
      response.each { |el| yield el }
    end

    private
    def api_uri(arguments, method = nil)
      uri = "/spaces/#{arguments.space}/space_tools/#{arguments.space_tool}/merge_requests/#{arguments.mr_id}/versions"
      uri += "/" + arguments['id'].to_s if arguments['id']
      uri += "/" + method.to_s if method
      uri
    end
  end
end
