#frozen_string_literal: true

require 'rails_helper'

RSpec.describe ApplicationHelper, type: :helper do
  describe '#present' do
    it 'instantiates a new PostPresenter object with a Post' do
      subject = Post.new

      result = present(subject)

      expect(result).to be_a(PostPresenter)
    end
  end
end
