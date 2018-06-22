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
end
