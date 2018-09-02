# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'blog/published_posts/index.html.erb' do
  before do
    create_list(:post, 2, :published)
    assign(:posts, Post.page)
  end

  it 'shows a link to change the state from published to hidden' do
    render

    expect(rendered).to have_link('Hide')
  end

  it 'shows a link to change the state from published to draft' do
    render

    expect(rendered).to have_link('Save as Draft')
  end
end
