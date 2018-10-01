# frozen_string_literal: true

FactoryBot.define do
  factory :post do
    author
    title 'Post Title'
    body 'I like to move it move it! You like to, MOVE IT!'
  end

  trait :draft do
    aasm_state 'draft'
  end

  trait :published do
    aasm_state 'published'
  end

  trait :hidden do
    aasm_state 'hidden'
  end

  trait :visible do
    publish_date Time.current - 1.day
  end

  trait :unreleased do
    publish_date Time.current + 2.days
  end

  trait :with_tags do
    after(:create) do |post|
      tag_list = create_list(:tag, 3)
      tag_list.each { |tag| create(:post_tag, post: post, tag: tag) }
    end
  end

  trait :with_categories do
    after(:create) do |post|
      cat_list = create_list(:category, 3)
      cat_list.each { |cat| create(:post_category, post: post, category: cat) }
    end
  end
end
