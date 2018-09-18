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
        post = create(:post, :hidden, title: 'Weird Slime Covers Ooo')
        create(:post, :hidden, title: 'PB Cracks Time Travel')

        patch :update, xhr: true, params: { id: post.id,
                                            new_state: 'published' }

        expect(response).to render_template(:update)
        expect(response.body).to include('PB Cracks Time Travel')
        expect(response.body).not_to include('Weird Slime Covers Ooo')
      end
    end
  end
end
