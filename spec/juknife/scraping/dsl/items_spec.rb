# frozen_string_literal: true

require 'spec_helper'
require 'nokogiri'

RSpec.describe Juknife::Scraping::DSL::Items do
  let(:owner) { nil }
  let(:html_source) { File.read('./spec/fixtures/test.html') }
  let(:document) { Nokogiri.parse(html_source) }
  let(:ctx) { Juknife::Scraping::Context.new(document, {}) }
  let(:item_name) { :profile }

  let(:item) do
    described_class.new(item_name, selector, &block)
  end

  let(:block) do
    proc do
      item :key, 'th'
      item :value, 'td'
    end
  end

  before do
    item.visit(ctx)
  end

  describe '#visit' do
    let(:selector) { '#profile-nyamadori .table > tr' }

    it 'finds an element' do
      expect(ctx.result[item_name]).to match [
        { key: 'height', value: '165cm' },
        { key: 'weight', value: '48kg' },
        { key: 'birthday', value: '1993.02.14' }
      ]
    end

    context 'when an element specified by the selector does not exist' do
      let(:selector) { '#profile-nyamadori .table-does-not-exist > tr' }

      it 'populates nil into the result' do
        expect(ctx.result[item_name]).to eq([])
      end
    end
  end
end
