# frozen_string_literal: true

describe Facter::Fedora::Mountpoints do
  let(:resolver_output) do
    [{ available: '63.31 GiB',
       available_bytes: 67_979_685_888,
       capacity: '84.64%',
       device: '/dev/nvme0n1p2',
       filesystem: 'ext4',
       options: %w[rw noatime],
       path: '/',
       size: '434.42 GiB',
       size_bytes: 466_449_743_872,
       used: '348.97 GiB',
       used_bytes: 374_704_357_376 }]
  end

  let(:parsed_fact) do
    { '/': { available: '63.31 GiB',
             available_bytes: 67_979_685_888,
             capacity: '84.64%',
             device: '/dev/nvme0n1p2',
             filesystem: 'ext4',
             options: %w[rw noatime],
             size: '434.42 GiB',
             size_bytes: 466_449_743_872,
             used: '348.97 GiB',
             used_bytes: 374_704_357_376 } }
  end

  context '#call_the_resolver' do
    it 'returns a fact' do
      expected_fact = double(Facter::ResolvedFact, name: 'mountpoints', value: parsed_fact)
      allow(Facter::Resolvers::Linux::Mountpoints).to receive(:resolve).with(:mountpoints).and_return(resolver_output)
      allow(Facter::ResolvedFact).to receive(:new).with('mountpoints', parsed_fact).and_return(expected_fact)

      fact = described_class.new
      expect(fact.call_the_resolver).to eq(expected_fact)
    end
  end
end
