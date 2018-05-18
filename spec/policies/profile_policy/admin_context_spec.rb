# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ProfilePolicy do
  subject { described_class.new(user, profile) }

  let(:user) { create(:user, :admin) }

  context "admin accessing someone else's profile" do
    let(:user2) { create(:user) }
    let(:profile) { create(:profile, user_id: user2.id) }

    it { is_expected.to permit_edit_and_update_actions }
    it { is_expected.to permit_action(:destroy) }
  end
end
