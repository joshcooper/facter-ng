# frozen_string_literal: true

module Facter
  class InternalFactManager
    def initialize
      @fact_hash = {
        'os.macosx.build' => {
          resolver: Resolvers::SwVers,
          argument: :buildversion
        },
        'os.macosx.product' => {
          resolver: Resolvers::SwVers,
          argument: :productname
        },
        'os.architecture' => {
          resolver: Resolvers::Uname,
          argument: :machine
        },
        'os.family' => {
          resolver: Resolvers::Uname,
          argument: :kernelname
        },
        'os.hardware' => {
          resolver: Resolvers::Uname.resolve(:machine),
        },
        'os.name' => {
          fact: Facter::Macosx::Osname
        },
        'ruby.platform' => {
          resolver: Resolvers::Ruby,
          argument: :platform
        },
        'ruby.sitedir' => {
          resolver: Resolvers::Ruby,
          argument: :sitedir
        },
        'ruby.version' => {
          resolver: Resolvers::Ruby,
          argument: :version
        }
      }
    end

    def resolve_facts(searched_facts)
      searched_facts = filter_internal_facts(searched_facts)

      resolve(searched_facts)
    end

    private

    def filter_internal_facts(searched_facts)
      searched_facts.select { |searched_fact| %i[core legacy].include? searched_fact.type }
    end


    def resolve(searched_facts)
      resolved_facts = []

      searched_facts.each do |searched_fact|
        resolver = @fact_hash[searched_fact.name][:resolver]
        resolver_argument = @fact_hash[searched_fact.name][:argument]
        custom_implementation = @fact_hash[searched_fact.name][:custom_implementation]
        if (custom_implementation)
          fact = Facter::FactFactory.build(searched_fact)
          resolved_facts << fact.create
        else
          fact_value = resolver.resolve(resolver_argument)
          resolved_facts << ResolvedFact.new(searched_fact.name, fact_value)
        end

      end

      resolved_facts.flatten!
      FactAugmenter.augment_resolved_facts(searched_facts, resolved_facts)
    end

  end
end
