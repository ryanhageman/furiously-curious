# frozen_string_literal: true

require 'rails_helper'

RSpec.describe PostPolicy do
  subject { described_class.new(user, post) }

  let(:user) { create(:user, :admin) }
  let(:post) { create(:post) }

  context 'admin creating a new post' do
    it { is_expected.to permit_new_and_create_actions }
  end

  context 'admin accessing a post' do
    it { is_expected.to permit_action(:show) }
    it { is_expected.to permit_edit_and_update_actions }
    it { is_expected.to permit_action(:destroy) }
  end

  context "admin accessing someone else's post" do
    let(:user2) { create(:user, :author) }
    let(:post) { create(:post, author_id: user2.id) }

    it { is_expected.to permit_edit_and_update_actions }
    it { is_expected.to permit_action(:destroy) }
  end
end
