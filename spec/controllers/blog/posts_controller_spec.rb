# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Blog::PostsController, type: :controller do
  let(:current_user) { create(:user) }

  before do
    sign_in current_user
    create(:profile, user_id: current_user.id)
  end

  context 'with invalid attributes' do
    let(:invalid_attributes) { attributes_for(:post, title: nil) }

    describe '#create' do
      it 're-renders the new post form' do
        post :create, params: { post: invalid_attributes }

        expect(response).to render_template(:new)
      end
    end

    describe '#update' do
      let(:post) { create(:post, title: 'Great Post') }

      it 're-renders the edit post form' do
        patch :update, params: { id: post.id, post: invalid_attributes }

        expect(response).to render_template(:edit)
      end
    end
  end
end
