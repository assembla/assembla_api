# encoding: utf-8

module Assembla
  module Validations
    module Required

      # Validate all keys present in a provided hash against required set,
      # on mismatch raise Assembla::Error::RequiredParams
      # Note that keys need to be in the same format i.e. symbols or strings,
      # otherwise the comparison will fail.
      #
      def assert_required_keys(required, provided)
        result = required.all? do |key|
          provided.deep_key? key
        end
        if !result
          raise Assembla::Error::RequiredParams.new(provided, required)
        end
        result
      end

    end # Required
  end # Validations
end # Assembla
