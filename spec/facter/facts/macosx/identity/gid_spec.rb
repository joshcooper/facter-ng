# frozen_string_literal: true

describe 'Macosx IdentityGid' do
  context '#call_the_resolver' do
    let(:value) { '20' }
    let(:expected_resolved_fact) { double(Facter::ResolvedFact, name: 'identity.gid', value: value) }
    subject(:fact) { Facter::Macosx::IdentityGid.new }

    before do
      expect(Facter::Resolvers::PosxIdentity).to receive(:resolve).with(:gid).and_return(value)
      expect(Facter::ResolvedFact).to receive(:new).with('identity.gid', value).and_return(expected_resolved_fact)
    end

    it 'returns identity.gid fact' do
      expect(fact.call_the_resolver).to eq(expected_resolved_fact)
    end
  end
end
