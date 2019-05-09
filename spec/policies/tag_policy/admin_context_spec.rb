# frozen_string_literal: true

require 'rails_helper'

RSpec.describe TagPolicy do
  subject { described_class.new(user, tag) }

  let(:user) { create(:user, :admin) }
  let(:tag) { create(:tag) }

  context 'admin creating a new tag' do
    it { is_expected.to permit_new_and_create_actions }
  end

  context 'admin is accessing a tag' do
    it { is_expected.to permit_action(:show) }
    it { is_expected.to permit_edit_and_update_actions }
    it { is_expected.to permit_action(:destroy) }
  end

  context "admin accessing a tag assigned to someone else's post" do
    let(:user2) { create(:user, :author) }
    let(:post) { create(:post, author_id: user2.id, tag_id: tag.id) }

    it { is_expected.to permit_edit_and_update_actions }
    it { is_expected.to permit_action(:destroy) }
  end
end
