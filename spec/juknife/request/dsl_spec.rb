require 'spec_helper'

RSpec.describe Juknife::Request::DSL do
  subject(:object) { Object.new.extend(described_class) }

  it { is_expected.to respond_to(:delete) }
  it { is_expected.to respond_to(:get) }
  it { is_expected.to respond_to(:head) }
  it { is_expected.to respond_to(:options) }
  it { is_expected.to respond_to(:patch) }
  it { is_expected.to respond_to(:post) }
  it { is_expected.to respond_to(:put) }

  describe '#get' do
    let(:request_url) { 'http://example.com' }

    context 'given `url` is String' do
      it 'assigns http_method and url_builder' do
        object.get request_url

        expect(object.http_method).to eq(:get)
        expect(object.url_builder).to be_kind_of(Proc)
        expect(object.url_builder.call).to eq(request_url)
      end
    end

    context 'given `url` is Proc' do
      it 'assigns http_method and url_builder' do
        object.get { request_url }

        expect(object.http_method).to eq(:get)
        expect(object.url_builder).to be_kind_of(Proc)
        expect(object.url_builder.call).to eq(request_url)
      end
    end
  end

  describe '#body' do
    let(:request_body) { 'http://example.com' }

    it 'assigns body_builder' do
      object.body { request_body }

      expect(object.body_builder).to be_kind_of(Proc)
      expect(object.body_builder.call).to eq(request_body)
    end
  end

  describe '#user_agent' do
    let(:user_agent) { 'Mozilla/4.0 (compatible; MSIE 7.0; Windows NT 6.0)' }

    it 'assigns user_agent_builder' do
      object.user_agent { user_agent }

      expect(object.user_agent_builder).to be_kind_of(Proc)
      expect(object.user_agent_builder.call).to eq(user_agent)
    end
  end

  describe '#query' do
    let(:query) do
      {
        q: 'keyword'
      }
    end

    it 'assigns user_agent_builder' do
      object.query { query }

      expect(object.query_builder).to be_kind_of(Proc)
      expect(object.query_builder.call).to eq(query)
    end
  end
end
