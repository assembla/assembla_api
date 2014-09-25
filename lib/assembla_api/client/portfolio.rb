module Assembla
  class Client::Portfolio < API
    require_all 'assembla_api/client/portfolio',
      'tasks',
      'users',
      'tickets',
      'spaces',
      'ticket_reports',
      'standup_reports',
      'invitations'

    namespace :tasks
    namespace :users
    namespace :tickets
    namespace :ticket_reports
    namespace :standup_reports
    namespace :invitations
  end
end
