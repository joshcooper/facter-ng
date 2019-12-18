# frozen_string_literal: true

describe 'Fedora RubyVersion' do
  context '#call_the_resolver' do
    subject(:call_the_resolver) { Facter::Fedora::RubyVersion.new.call_the_resolver }
    let(:version) { '2.6.3' }

    before do
      allow(Facter::Resolvers::Ruby).to \
        receive(:resolve).with(:version).and_return(version)
    end

    it 'calls Facter::Resolvers::Ruby' do
      call_the_resolver
      expect(Facter::Resolvers::Ruby).to have_received(:resolve).with(:version)
    end

    it 'returns a resolved fact' do
      expect(call_the_resolver).to be_an_instance_of(Facter::ResolvedFact).and \
        have_attributes(name: 'ruby.version', value: version)
    end
  end
end
