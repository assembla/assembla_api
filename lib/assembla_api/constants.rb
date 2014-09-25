module Assembla
  module Constants
    extend self

    # Response headers
    RATELIMIT_REMAINING = 'X-RateLimit-Remaining'.freeze

    RATELIMIT_LIMIT = 'X-RateLimit-Limit'.freeze

    CONTENT_TYPE = 'Content-Type'.freeze

    CONTENT_LENGTH = 'content-length'.freeze

    CACHE_CONTROL = 'cache-control'.freeze

    ETAG = 'ETag'.freeze

    SERVER = 'Server'.freeze

    DATE = 'Date'.freeze

    LOCATION = 'Location'.freeze

    USER_AGENT = 'User-Agent'.freeze

    ACCEPT = 'Accept'.freeze

    ACCEPT_CHARSET = 'Accept-Charset'.freeze

    OAUTH_SCOPES = 'X-Oauth-Scopes'.freeze

    ACCEPTED_OAUTH_SCOPES = 'X-Accepted-Oauth-Scopes'.freeze

    # Link headers
    HEADER_LINK = "Link".freeze

    HEADER_NEXT = "X-Next".freeze

    HEADER_LAST = "X-Last".freeze

    META_REL = "rel".freeze

    META_LAST = "last".freeze

    META_NEXT = "next".freeze

    META_FIRST = "first".freeze

    META_PREV = "prev".freeze

    PARAM_PAGE = "page".freeze

    PARAM_PER_PAGE = "per_page".freeze

    PARAM_START_PAGE = "start_page".freeze

    class ToolTypes
      MILESTONES = 9
      STANDUP = 10
      TICKETS  = 13
      FILES = 18
      MESSAGES = 21
      WIKI = 23
      WEBHOOKS = 112
      GIT = 128
      SSH = 200
      # TODO add all tools
      ALL = [ MESSAGES, TICKETS, MILESTONES, FILES, STANDUP, GIT, WIKI, WEBHOOKS,
        SSH
       ]
    end

  end # Constants
end # Assembla
