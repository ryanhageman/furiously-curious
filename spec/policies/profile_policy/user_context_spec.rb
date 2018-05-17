# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ProfilePolicy do
  subject { described_class.new(user, profile) }

  let(:user) { create(:user) }
  let(:profile) { create(:profile, user_id: user.id) }

  context 'user creating a new profile' do
    it { is_expected.to permit_new_and_create_actions }
  end

  context 'user accessing their own profile' do
    it { is_expected.to permit_action(:show) }
    it { is_expected.to permit_edit_and_update_actions }
    it { is_expected.to permit_action(:destroy) }
  end

  context "user accessing someone else's profile" do
    let(:user2) { create(:user) }
    let(:profile) { create(:profile, user_id: user2.id) }

    it { is_expected.to permit_action(:show) }
    it { is_expected.to forbid_edit_and_update_actions }
    it { is_expected.to forbid_action(:destroy) }
  end

  context 'user accessing profile index view' do
    it { is_expected.to permit_action(:index) }
  end
end
