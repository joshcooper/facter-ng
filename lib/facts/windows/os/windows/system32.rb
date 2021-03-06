# frozen_string_literal: true

module Facter
  module Windows
    class OsWindowsSystem32
      FACT_NAME = 'os.windows.system32'

      def call_the_resolver
        fact_value = Resolvers::System32.resolve(:system32)

        ResolvedFact.new(FACT_NAME, fact_value)
      end
    end
  end
end
