# frozen_string_literal: true

require 'rails_helper'

RSpec.describe CategoryPolicy do
  subject { described_class.new(user, category) }

  let(:user) { create(:user) }
  let(:category) { create(:category) }

  context 'user creating a new category' do
    it { is_expected.to forbid_new_and_create_actions }
  end

  context 'user accessing a category' do
    it { is_expected.to permit_action(:show) }
  end

  context 'user destroying a category' do
    it { is_expected.to forbid_action(:destroy) }
  end

  context 'user editing a category' do
    it { is_expected.to forbid_edit_and_update_actions }
  end
end
