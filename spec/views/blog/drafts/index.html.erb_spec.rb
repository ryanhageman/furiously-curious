# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'blog/drafts/index.html.erb' do
  it 'shows a link to change the state from draft to published' do
    create_list(:post, 2)
    assign(:posts, Post.page)
    render

    expect(rendered).to have_link('Publish')
  end
end
