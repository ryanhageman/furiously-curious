# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'blog/hidden_posts/index.html.erb' do
  before do
    create_list(:post, 2, :hidden)
    assign(:posts, Post.page)
  end

  it 'shows a link to change the state from hidden to published' do
    render

    expect(rendered).to have_link('Publish')
  end

  it 'shows a link to change the state from hidden to draft' do
    render

    expect(rendered).to have_link('Save as Draft')
  end
end
