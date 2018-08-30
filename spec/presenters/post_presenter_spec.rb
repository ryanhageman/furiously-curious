# frozen_string_literal: true

require 'rails_helper'

RSpec.describe PostPresenter do
  let(:view) { ActionController::Base.new.view_context }

  it 'returns a link to publish a post for drafts' do
    post = create(:post, :draft)
    presenter = PostPresenter.new(post, view)

    expect(presenter.change_state_links).to include('?new_state=published')
  end

  it 'returns links to save as draft and hide for published posts' do
    post = create(:post, :published)
    presenter = PostPresenter.new(post, view)

    expect(presenter.change_state_links).to include('?new_state=draft')
    expect(presenter.change_state_links).to include('?new_state=hidden')
  end

  it 'returns links to save as draft and publish for hidden posts' do
    post = create(:post, :hidden)
    presenter = PostPresenter.new(post, view)

    expect(presenter.change_state_links).to include('?new_state=draft')
    expect(presenter.change_state_links).to include('?new_state=published')
  end
end
