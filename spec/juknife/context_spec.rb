# frozen_string_literal: true

require 'spec_helper'
require 'nokogiri'

RSpec.describe Juknife::Context do
  let(:owner) { nil }
  let(:html_source) { File.read('./spec/fixtures/test.html') }
  let(:document) { Nokogiri::HTML(html_source) }
  let(:ctx) { Juknife::Context.new(owner, document, {}) }

  describe '#item' do
    context 'find an element' do
      before do
        ctx.item :user_id, '#profile-nyamadori > h1.header'
      end

      it { expect(ctx.result[:user_id]).to eq('nyamadori') }
    end

    context 'find an element that have multiline text' do
      before do
        ctx.item :comment, '#profile-nyamadori > p.comment'
      end

      it 'populates normalized text into the result' do
        expect(ctx.result[:comment]).to eq(<<~END.chomp)
          I'm a Ruby programmer.
          Please give me chocolate!
        END
      end
    end

    context 'does not find an element' do
      it 'populates nil into the result' do
        ctx.item :item, '#profile-nyamadori > p.invalid'
        expect(ctx.result[:item]).to eq(nil)
      end
    end
  end

  describe '#items' do
    it 'populates an array of hash into the result' do
      ctx.items :data_sheet, '#profile-nyamadori tr' do |ds|
        ds.item :key, 'th'
        ds.item :value, 'td'
      end

      expect(ctx.result[:data_sheet]).to match_array(
        [
          { key: 'height', value: '165cm' },
          { key: 'weight', value: '48kg' },
          { key: 'birthday', value: '1993.02.14' }
        ]
      )
    end
  end
end
