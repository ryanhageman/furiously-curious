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
        subject = create(:post, :published, title: 'ZOINKS! THE BLACK KNIGHT!')
        other_post = create(:post, :published, title: 'Mr. Wickles CAUGHT!')

        result = patch :update,
                       xhr: true,
                       params: { id: other_post.id, new_state: 'hidden' }

        expect(result).to render_template(:update)
        expect(result.body).to include(subject.title)
        expect(result.body).not_to include(other_post.title)
      end
    end
  end
end
