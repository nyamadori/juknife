# frozen_string_literal: true

require 'spec_helper'
require 'nokogiri'

RSpec.describe Juknife::Context do
  let(:owner) { nil }
  let(:html_source) { File.read('./spec/fixtures/test.html') }
  let(:document) { Nokogiri::HTML(html_source) }
  let(:ctx) { Juknife::Context.new(owner, document, {}) }

  describe '#item' do
    context 'when the xpath find an element' do
      it 'populates suitable header text into the result' do
        ctx.item :user_id, '//div[@id="profile-nyamadori"]/h1[@class="header"]'
        expect(ctx.result[:user_id]).to eq('nyamadori')
      end

      it 'populates normalized comment text into the result' do
        ctx.item :comment, '//div[@id="profile-nyamadori"]/p[@class="comment"]'
        expect(ctx.result[:comment]).to eq(<<~END.chomp)
          I'm a Ruby programmer.
          Please give me chocolate!
        END
      end
    end

    context 'when the xpath do not find an element' do
      it 'populates nil into the result' do
        ctx.item :item, '//div[@id="profile-nyamadori"]/p[@class="invalid"]'
        expect(ctx.result[:item]).to eq(nil)
      end
    end
  end

  describe '#items' do
    it 'populates ...' do
      ctx.items :data_sheet, '//div[@id="profile-nyamadori"]//tr' do
        # string :comment, 'xpath'
        # hash :data_sheet, 'xpath' do |ds|
        #   ds.symbol :key, '//th'
        #   ds.string :value, '//td'
        # end
      end
    end
  end

  describe '#write_item'
  describe '#write_items'
  describe '#normalize_text'
end
