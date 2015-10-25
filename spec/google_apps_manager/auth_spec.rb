require 'spec_helper'

describe GoogleAppsManager::Auth do
  subject { GoogleAppsManager::Auth.new(config) }

  let(:config)    { YAML.load_file(file_path)       }
  let(:file_path) { 'spec/config/sample_config.yml' }

  describe '#new', vcr: { cassette_name: 'google_api_authorize' } do
    it { expect { subject }.not_to raise_error }
  end
end
