# frozen_string_literal: true

require 'rails_helper'

RSpec.describe CategoriesController, type: :controller do
  let(:current_user) { create(:user) }

  before { sign_in current_user }

  context 'with invalid attributes' do
    let(:invalid_attributes) do
      attributes_for(:category, :invalid_category_name)
    end

    describe '#create' do
      it 're-renders the new category form' do
        post :create, params: { category: invalid_attributes }

        expect(response).to render_template(:new)
      end
    end

    describe '#update' do
      let(:category) { create(:category, name: 'the category') }

      it 're-renders the edit category form' do
        patch :update, params: {
          id: category.id,
          category: invalid_attributes
        }

        expect(response).to render_template(:edit)
      end
    end
  end
end