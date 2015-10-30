require 'spec_helper'
require 'find'

include GoogleAppsManager

describe Client do
  let(:client) { Client.new(config) }
  let(:config) { YAML.load_file('spec/config/sample_config.yml') }

  describe '#client' do
    subject { client.client }
    it { is_expected.to be_instance_of Google::APIClient }
  end

  describe '#download' do
    subject { client.download }
    before do
      allow_any_instance_of(Downloader).to receive(:result).and_return(result)
      allow_any_instance_of(Downloader).to receive(:success?).and_return(success)
      allow(client).to receive(:authorize!).and_return(client)
    end

    let(:result) { double('result', status: status, body: body) }
    let(:body)   { { files: [{ 'name': 'test', 'source': Faker::Lorem.paragraph, 'type': 'html' }] }.to_json }
    let(:status) { 200 }

    context 'download failed' do
      let(:success) { false }
      it { expect { subject }.to raise_error Client::DownloadError }
    end

    context 'download success' do
      let(:success) { true }
      it { expect { subject }.not_to raise_error }
    end
  end
end
