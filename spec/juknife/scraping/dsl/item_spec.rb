# frozen_string_literal: true

require 'spec_helper'
require 'nokogiri'

RSpec.describe Juknife::Scraping::DSL::Item do
  let(:owner) { nil }
  let(:html_source) { File.read('./spec/fixtures/test.html') }
  let(:document) { Nokogiri.parse(html_source) }
  let(:ctx) { Juknife::Scraping::Context.new(document, {}) }
  let(:item) { described_class.new(name, selector) }

  before do
    item.visit(ctx)
  end

  describe '#visit' do
    context 'finds an element' do
      let(:name) { :user_id }
      let(:selector) { '#profile-nyamadori > h1.header' }
      it { expect(ctx.result[:user_id]).to eq('nyamadori') }
    end

    context 'finds an element that have multiline text' do
      let(:name) { :comment }
      let(:selector) { '#profile-nyamadori > p.comment' }

      it 'populates normalized text into the result' do
        expect(ctx.result[:comment]).to eq(<<~END.chomp)
          I'm a Ruby programmer.
          Please give me chocolate!
        END
      end
    end

    context 'does not find an element' do
      let(:name) { :item }
      let(:selector) { '#profile-nyamadori > p.invalid' }

      it 'populates nil into the result' do
        expect(ctx.result[:item]).to eq(nil)
      end
    end
  end
end
