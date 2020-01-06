# frozen_string_literal: true

describe 'Windows DmiProductName' do
  context '#call_the_resolver' do
    let(:value) { 'VMware7,1' }
    let(:expected_resolved_fact) { double(Facter::ResolvedFact, name: 'dmi.product.name', value: value) }
    let(:resolved_legacy_fact) { double(Facter::ResolvedFact, name: 'productname', value: value, type: :legacy) }
    subject(:fact) { Facter::Windows::DmiProductName.new }

    before do
      expect(Facter::Resolvers::DMIComputerSystem).to receive(:resolve).with(:name).and_return(value)
      expect(Facter::ResolvedFact).to receive(:new).with('dmi.product.name', value).and_return(expected_resolved_fact)
      expect(Facter::ResolvedFact).to receive(:new).with('productname', value, :legacy)
                                                   .and_return(resolved_legacy_fact)
    end

    it 'returns product name fact' do
      expect(fact.call_the_resolver).to eq([expected_resolved_fact, resolved_legacy_fact])
    end
  end
end
