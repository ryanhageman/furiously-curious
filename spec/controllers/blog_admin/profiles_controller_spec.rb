# frozen_string_literal: true

require 'rails_helper'

RSpec.describe BlogAdmin::ProfilesController, type: :controller do
  let(:current_user) { create(:user, :admin) }

  before { sign_in current_user }

  context 'with invalid attributes' do
    let(:invalid_attributes) do
      attributes_for(:profile, :invalid_username)
    end

    describe '#create' do
      it 're-renders the new form' do
        result = post :create, params: { profile: invalid_attributes }

        expect(result).to render_template(:new)
      end
    end

    describe '#update' do
      let(:subject) { create(:profile, user_id: current_user.id) }

      it 're-renders the edit form' do
        result = patch :update,
                       params: { id: subject.id, profile: invalid_attributes }

        expect(result).to render_template(:edit)
      end
    end
  end
end
