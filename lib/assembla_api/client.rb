# encoding: utf-8

module Assembla
  class Client < API

    require_all 'assembla_api/client',
      'activity',
      'authorizations',
      'issues',
      'pull_requests',
      'repos',
      'users'

    # Serving up the ‘social’ in Social Coding™, the Activity APIs
    # provide access to notifications, subscriptions, and timelines.
    namespace :activity

    # An API for users to manage their own tokens. You can only access your own
    # tokens, and only through Basic Authentication.
    namespace :authorizations
    alias :oauth :authorizations

    namespace :pull_requests
    alias :pulls :pull_requests

    namespace :repos
    alias :repositories :repos

    namespace :scopes

    namespace :search

    # Many of the resources on the users API provide a shortcut for getting
    # information about the currently authenticated user.
    namespace :users
  end # Client
end # Assembla
