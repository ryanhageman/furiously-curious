# frozen_string_literal: true

require 'rails_helper'

RSpec.describe BlogAdmin::HiddenPostsController, type: :controller do
  let(:current_user) { create(:user, :admin) }

  before do
    sign_in current_user
    create(:profile, user_id: current_user.id)
  end

  context 'update post state' do
    describe '#update' do
      render_views

      it 'only shows posts that are still hidden' do
        subject = create(:post, :hidden, title: 'PB Cracks Time Travel')
        other_post = create(:post, :hidden, title: 'Weird Slime Covers Ooo')

        result = patch :update,
                       xhr: true,
                       params: { id: other_post.id, new_state: 'published' }

        expect(result).to render_template(:update)
        expect(result.body).to include(subject.title)
        expect(result.body).not_to include(other_post.title)
      end
    end
  end
end
