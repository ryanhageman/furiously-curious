# frozen_string_literal: true

FactoryBot.define do
  sequence(:tag_name) { |n| "tag name#{n}" }
  factory :tag do
    name { generate(:tag_name) }

    trait :invalid_tag_name do
      name nil
    end
  end
end
