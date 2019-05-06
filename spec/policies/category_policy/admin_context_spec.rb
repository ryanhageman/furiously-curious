# frozen_string_literal: true

require 'rails_helper'

RSpec.describe CategoryPolicy do
  subject { described_class.new(user, category) }

  let(:user) { create(:user, :admin) }
  let(:category) { create(:category) }

  context 'admin creating a new category' do
    it { is_expected.to permit_new_and_create_actions }
  end

  context 'admin accessing a category' do
    it { is_expected.to permit_action(:show) }
    it { is_expected.to permit_edit_and_update_actions }
    it { is_expected.to permit_action(:destroy) }
  end

  context "admin accessing a category assigned to someone else's post" do
    let(:user2) { create(:user, :author) }
    let(:post) { create(:post, author_id: user2.id, category_id: category.id) }

    it { is_expected.to permit_edit_and_update_actions }
    it { is_expected.to permit_action(:destroy) }
  end
end
