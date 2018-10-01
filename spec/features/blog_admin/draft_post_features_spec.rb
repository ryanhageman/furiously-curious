# frozen_string_literal: true

require 'rails_helper'

RSpec.feature 'BlogAdmin::Drafts Features', type: :feature do
  let(:current_user) { create(:user) }

  before { login_as current_user }

  describe 'user searches drafts index' do
    scenario 'they see all the matching posts' do
      subject1 = create(:post, title: 'Lightsaber')
      subject2 = create(:post, title: 'Sabertooth Tiger')
      other_post = create(:post, title: 'Jedi')

      visit blog_admin_drafts_path
      fill_in 'search', with: 'saber'
      click_on 'Search'

      result = page

      expect(result).to have_content(subject1.title)
      expect(result).to have_content(subject2.title)
      expect(result).not_to have_content(other_post.title)
    end
  end
end
