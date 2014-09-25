module Assembla
  class Client::Spaces::SpaceTools::MergeRequests::Versions::Votes < API

    # @example
    # api.spaces.space_tools.merge_requests.versions.votes.up 'project1', 'git', 571, 1
    def up(*args)
      arguments(args, required: [:space, :space_tool, :mr_id, :version])
      post_request api_uri(arguments, :upvote), arguments.params
    end

    # @example
    # api.spaces.space_tools.merge_requests.versions.votes.down 'project1', 'git', 571, 1
    def down(*args)
      arguments(args, required: [:space, :space_tool, :mr_id, :version])
      post_request api_uri(arguments, :downvote), arguments.params
    end

    # Deletes vote from MR version
    #
    # @example
    # api.spaces.space_tools.merge_requests.versions.votes.delete 'project1', 'git', 571, 1
    def delete(*args)
      arguments(args, required: [:space, :space_tool, :mr_id, :version])
      delete_request api_uri(arguments, :delete), arguments.params
    end

    alias :remove :delete

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
      uri = "/spaces/#{arguments.space}/space_tools/#{arguments.space_tool}/merge_requests/#{arguments.mr_id}/versions/#{arguments.version}/votes"
      uri += "/" + arguments['id'].to_s if arguments['id']
      uri += "/" + method.to_s if method
      uri
    end
  end
end
