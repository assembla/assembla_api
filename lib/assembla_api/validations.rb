# encoding: utf-8

module Assembla
  module Validations

    Assembla::require_all 'assembla_api/validations',
      'presence',
      'token',
      'format',
      'required'

    include Presence
    include Format
    include Token
    include Required

    VALID_API_KEYS = [
      'page',
      'per_page',
      'auto_pagination',
      'jsonp_callback'
    ]

  end # Validation
end # Assembla
