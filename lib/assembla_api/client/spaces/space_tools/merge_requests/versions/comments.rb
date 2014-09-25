module Assembla
  class Client::Spaces::SpaceTools::MergeRequests::Versions::Comments < API

    # @example
    # api.spaces.space_tools.merge_requests.versions.comments.create 'project1', 'git', 571, 1,
    #    content: 'Looks good to me'
    def create(*args)
      fields = %w[ content ]
      arguments(args, required: [:space, :space_tool, :mr_id, :version]) do
        permit fields
        assert_required fields
      end

      post_request api_uri(arguments), arguments.params
    end

    # @example
    # api.spaces.space_tools.space_tools.merge_requests.versions.list 'project1', 'git', 571, 1
    def list(*args)
      arguments(args, required: [:space, :space_tool, :mr_id, :version])
      response = get_request api_uri(arguments), arguments.params
      return response unless block_given?
      response.each { |el| yield el }
    end

    private
    def api_uri(arguments, method = nil)
      uri = "/spaces/#{arguments.space}/space_tools/#{arguments.space_tool}/merge_requests/#{arguments.mr_id}/versions/#{arguments.version}/comments"
      uri += "/" + arguments['id'].to_s if arguments['id']
      uri += "/" + method.to_s if method
      uri
    end
  end
end
