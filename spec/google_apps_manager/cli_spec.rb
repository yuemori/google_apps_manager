require 'spec_helper'

describe GoogleAppsManager::CLI do
  let(:cli) { GoogleAppsManager::CLI.new }

  describe '#init', vcr: { cassette_name: 'google_api_authorize' }do
    subject { cli.init }
    before do
      ENV['GAM_CONFIG_FILE'] = 'spec/config/sample_config.yml'
    end

    it { expect { subject }.not_to raise_error }
  end
end
