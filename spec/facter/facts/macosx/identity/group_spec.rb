# frozen_string_literal: true

describe 'Macosx IdentityGroup' do
  context '#call_the_resolver' do
    let(:value) { 'staff' }
    let(:expected_resolved_fact) { double(Facter::ResolvedFact, name: 'identity.group', value: value) }
    subject(:fact) { Facter::Macosx::IdentityGroup.new }

    before do
      expect(Facter::Resolvers::PosxIdentity).to receive(:resolve).with(:group).and_return(value)
      expect(Facter::ResolvedFact).to receive(:new).with('identity.group', value).and_return(expected_resolved_fact)
    end

    it 'returns identity.group fact' do
      expect(fact.call_the_resolver).to eq(expected_resolved_fact)
    end
  end
end
