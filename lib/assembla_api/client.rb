# encoding: utf-8

module Assembla
  class Client < API

    require_all 'assembla_api/client',
      'activity',
      'spaces',
      'tasks',
      'users'

    namespace :activity
    namespace :spaces

    # Many of the resources on the users API provide a shortcut for getting
    # information about the currently authenticated user.
    namespace :users
  end # Client
end # Assembla
