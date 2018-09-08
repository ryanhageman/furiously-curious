#frozen_string_literal: true

require 'rails_helper'

RSpec.describe ApplicationHelper, type: :helper do
  describe '#present' do
    it 'instantiates a new Presenter object' do
      post = Post.new
      expect(present(post)).to be_a(PostPresenter)
    end
  end
end
