# frozen_string_literal: true

require 'spec_helper'
require 'nokogiri'

RSpec.describe Juknife::Scraping::DSL::Scope do
  let(:html_source) { File.read('./spec/fixtures/test.html') }
  let(:document) { Nokogiri.parse(html_source) }
  let(:ctx) { Juknife::Scraping::Context.new(document, {}) }

  let(:item) do
    described_class.new(selector, &block)
  end

  let(:block) do
    proc do
      item :name, '.header'
      item :github, '.github'
    end
  end

  before do
    item.visit(ctx)
  end

  describe '#visit' do
    let(:selector) { '#profile-nyamadori' }

    it 'populates name and comment into the result' do
      expect(ctx.result[:name]).to eq('nyamadori')
      expect(ctx.result[:github]).to eq('@nyamadorim')
    end
  end
end
