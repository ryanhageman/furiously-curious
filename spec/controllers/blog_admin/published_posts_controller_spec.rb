# frozen_string_literal: true

require 'rails_helper'

RSpec.describe BlogAdmin::PublishedPostsController, type: :controller do
  let(:current_user) { create(:user, :admin) }

  before do
    sign_in current_user
    create(:profile, user_id: current_user.id)
  end

  context 'update post state' do
    describe '#update' do
      render_views

      it 'only shows posts that are still published' do
        post = create(:post, :published, title: 'Mr. Wickles CAUGHT!')
        create(:post, :published, title: 'ZOINKS! Like, THE BLACK KNIGHT!')

        patch :update, xhr: true, params: { id: post.id,
                                            new_state: 'hidden' }

        expect(response).to render_template(:update)
        expect(response.body).to include('ZOINKS! Like, THE BLACK KNIGHT!')
        expect(response.body).not_to include('Mr. Wickles CAUGHT!')
      end
    end
  end
end
