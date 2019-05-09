# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ProfilePolicy do
  subject { described_class.new(user, profile) }

  let(:user) { create(:user, :author) }
  let(:profile) { create(:profile, user_id: user.id) }

  context "user or author accessing someone else's profile" do
    let(:user2) { create(:user) }
    let(:profile) { create(:profile, user_id: user2.id) }

    it { is_expected.to permit_action(:show) }
    it { is_expected.to forbid_edit_and_update_actions }
    it { is_expected.to forbid_action(:destroy) }
  end

  context 'any user accessing profile index view' do
    it { is_expected.to permit_action(:index) }
  end
end
