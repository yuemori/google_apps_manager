require 'spec_helper'

include GoogleAppsManager

describe CLI do
  let(:script) { Script.new(name: name, source: source, type: type) }
  let(:name)   { 'test' }
  let(:source) { Faker::Lorem.paragraph }
  let(:type)   { 'html' }

  describe '#name' do
    subject { script.name }
    let(:result) { name + expantion }

    context 'type is html' do
      let(:expantion) { '.html' }
      it { is_expected.to eq result }
    end

    context 'type is server_js' do
      let(:type)      { 'server_js' }
      let(:expantion) { '.js' }
      it { is_expected.to eq result }
    end
  end
end
