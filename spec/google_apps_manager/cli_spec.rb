require 'spec_helper'

include GoogleAppsManager
describe CLI do
  let(:cli) { CLI.new }
  let(:config) { { dist: 'tmp' } }

  before do
    allow(cli).to receive(:authorization).and_return(client)
    allow(cli).to receive(:config).and_return(config)
  end

  describe '#init' do
    subject { cli.init }
    let(:client) { double('client') }

    it { expect { subject }.not_to raise_error }
  end

  describe '#pull' do
    subject { cli.pull }
    let(:client)   { double('client', download: download) }
    let(:download) { [double('script', name: 'test')] }

    it { expect { subject }.not_to raise_error }
  end
end
