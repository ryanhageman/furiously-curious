# frozen_string_literal: true

require 'rails_helper'

RSpec.describe BlogAdmin::DraftsController, type: :controller do
  let(:current_user) { create(:user, :admin) }

  before do
    sign_in current_user
    create(:profile, user_id: current_user.id)
  end

  context 'update post state' do
    describe '#update' do
      render_views

      it 'only shows posts that are still drafts' do
        post = create(:post, title: 'Boba Fett Wins')
        create(:post, title: 'Yoda Turns 984 Today')

        patch :update, xhr: true, params: { id: post.id,
                                            new_state: 'published' }

        expect(response).to render_template(:update)
        expect(response.body).to include('Yoda Turns 984 Today')
        expect(response.body).not_to include('Boba Fett Wins')
      end
    end
  end
end
