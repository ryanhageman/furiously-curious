# frozen_string_literal: true

require 'rails_helper'

RSpec.describe PostPolicy do
  subject { described_class.new(user, post) }

  let(:user) { create(:user, :author) }
  let(:post) { create(:post, author_id: user.id) }

  context 'author accessing post index view' do
    it { is_expected.to permit_action(:index) }
  end

  context 'author creating a new post' do
    it { is_expected.to permit_new_and_create_actions }
  end

  context 'author accessing their own post' do
    it { is_expected.to permit_action(:show) }
    it { is_expected.to permit_edit_and_update_actions }
    it { is_expected.to permit_action(:destroy) }
  end

  context "user or author accessing someone else's post" do
    let(:user2) { create(:user, :author) }
    let(:post) { create(:post, author_id: user2.id) }

    it { is_expected.to forbid_action(:show) }
    it { is_expected.to forbid_edit_and_update_actions }
    it { is_expected.to forbid_action(:destroy) }
  end
end
