# frozen_string_literal: true

module Facter
  module Macosx
    class OsMacosxProduct
      FACT_NAME = 'os.macosx.product'

      def call_the_resolver
        fact_value = Resolvers::SwVers.resolve(:productname)

        ResolvedFact.new(FACT_NAME, fact_value)
      end
    end
  end
end
