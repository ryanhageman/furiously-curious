# frozen_string_literal: true

require 'rails_helper'

RSpec.describe TagPolicy do
  subject { described_class.new(user, tag) }

  let(:user) { create(:user) }
  let(:tag) { create(:tag) }

  context 'user creating a new tag' do
    it { is_expected.to forbid_new_and_create_actions }
  end

  context 'user accessing a tag' do
    it { is_expected.to permit_action(:show) }
  end

  context 'user destroying a tag' do
    it { is_expected.to forbid_action(:destroy) }
  end

  context 'user editing a tag' do
    it { is_expected.to forbid_edit_and_update_actions }
  end
end
