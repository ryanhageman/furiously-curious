# frozen_string_literal: true

require 'rails_helper'

RSpec.describe MarkdownHelper, type: :helper do
  describe '#markdown' do
    it 'changes markdown to html' do
      headline = '# Yoda Assults R2 Over Protein Bar!'
      subject = "# #{headline}"

      result = markdown(subject)

      expect(result).to include("<h1>#{headline}</h1>")
    end
  end
end
