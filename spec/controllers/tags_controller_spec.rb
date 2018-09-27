# frozen_string_literal: true

require 'rails_helper'

RSpec.describe TagsController, type: :controller do
  let(:current_user) { create(:user) }

  before { sign_in current_user }

  context 'with invalid attributes' do
    let(:invalid_attributes) do
      attributes_for(:tag, :invalid_tag_name)
    end

    describe '#create' do
      it 're-renders the new tag form' do
        result = post :create, params: { tag: invalid_attributes }

        expect(result).to render_template(:new)
      end
    end

    describe '#update' do
      let(:subject) { create(:tag, name: 'the tag') }

      it 're-renders the edit tag form' do
        result = patch :update,
                       params: { id: subject.id, tag: invalid_attributes }

        expect(result).to render_template(:edit)
      end
    end
  end
end
