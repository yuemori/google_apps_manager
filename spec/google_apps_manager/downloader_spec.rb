require 'spec_helper'

include GoogleAppsManager

describe Downloader do
  let(:downloader) { Downloader.new(file_id, client) }
  let(:client)     { Class.new }
  let(:file_id)    { ENV['FILE_ID'] || '' }
  let(:config)     { YAML.load_file('spec/config/sample_config.yml') }

  describe '#success' do
    subject { downloader.success? }
    before { allow_any_instance_of(Downloader).to receive(:result).and_return(result) }
    let(:result_stub) { Struct.new(:status) }

    context 'status 200' do
      let(:result) { result_stub.new(200) }

      it { is_expected.to be_truthy }
    end

    context 'status not 200' do
      let(:result) { result_stub.new(404) }

      it { is_expected.to be_falsy }
    end
  end
end
