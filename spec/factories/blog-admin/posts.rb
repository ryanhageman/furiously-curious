# frozen_string_literal: true

# Post Factory
FactoryBot.define do
  sequence(:title) { |n| "Post Title #{n}" }

  factory :post do
    author
    title
    body { 'I like to move it move it! You like to, MOVE IT!' }
  end
end

# Post States
FactoryBot.define do
  trait :draft do
    aasm_state { 'draft' }
  end

  trait :published do
    aasm_state { 'published' }
    publish_date { Time.current }
  end

  trait :hidden do
    aasm_state { 'hidden' }
  end
end

# Post Visibility
FactoryBot.define do
  trait :visible do
    publish_date { Time.current - 1.day }
  end

  trait :unreleased do
    publish_date { Time.current + 2.days }
  end
end

# Post with tags
FactoryBot.define do
  trait :with_tags do
    after(:create) do |post|
      tag_list = create_list(:tag, 3)
      tag_list.each { |tag| create(:post_tag, post: post, tag: tag) }
    end
  end

  trait :with_specific_tag do
    transient do
      tag { create(:tag) }
    end

    after(:create) do |post, evaluator|
      create(:post_tag, post: post, tag: evaluator.tag)
    end
  end
end

# Post with Categories
FactoryBot.define do
  trait :with_categories do
    after(:create) do |post|
      cat_list = create_list(:category, 3)
      cat_list.each { |cat| create(:post_category, post: post, category: cat) }
    end
  end

  trait :with_specific_category do
    transient do
      category { create(:category) }
    end

    after(:create) do |post, evaluator|
      create(:post_category, post: post, category: evaluator.category)
    end
  end
end
