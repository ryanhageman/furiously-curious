# frozen_string_literal: true

require 'rails_helper'

RSpec.describe MarkdownHelper, type: :helper do
  describe '#markdown' do
    it 'changes markdown to html' do
      text = '# Yoda Assults R2!'
      expect(markdown(text)).to include('<h1>Yoda Assults R2!</h1>')
    end
  end
end
