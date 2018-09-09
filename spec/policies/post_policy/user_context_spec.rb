# frozen_string_literal: true

require 'rails_helper'

RSpec.describe PostPolicy do
  subject { described_class.new(user, post) }

  let(:user) { create(:user) }
  let(:post) { create(:post) }

  context 'any user creating a new post' do
    it { is_expected.to forbid_new_and_create_actions }
  end

  context 'any user accessing a post' do
    it { is_expected.to forbid_action(:show) }
    it { is_expected.to forbid_edit_and_update_actions }
    it { is_expected.to forbid_action(:destroy) }
  end
end
