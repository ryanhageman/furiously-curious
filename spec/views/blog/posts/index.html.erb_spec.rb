# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'blog/posts/index.html.erb' do
  before do
    create(:post, :published)
    create(:post, :draft)
    create(:post, :hidden)
    assign(:posts, Post.page)
  end

  it 'shows a link to change the state to hidden' do
    render

    expect(rendered).to have_link('Hide')
  end

  it 'shows a link to change the state to draft' do
    render

    expect(rendered).to have_link('Save as Draft')
  end

  it 'shows a link to change the state to published' do
    render

    expect(rendered).to have_link('Publish')
  end
end
