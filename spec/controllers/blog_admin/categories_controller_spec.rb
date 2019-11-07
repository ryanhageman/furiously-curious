# frozen_string_literal: true

require 'rails_helper'

RSpec.describe BlogAdmin::CategoriesController, type: :controller do
  let(:current_user) { create(:user, :admin) }

  before { sign_in current_user }

  context 'with invalid attributes' do
    let(:invalid_attributes) do
      attributes_for(:category, :invalid_category_name)
    end

    describe '#create' do
      it 're-renders the new category form' do
        result = post :create, params: { category: invalid_attributes }

        expect(result).to render_template(:new)
      end
    end

    describe '#update' do
      let(:subject) { create(:category, name: 'the category') }

      it 're-renders the edit category form' do
        result = patch  :update,
                        params: { id: subject.id, category: invalid_attributes }

        expect(result).to render_template(:edit)
      end
    end
  end
end
