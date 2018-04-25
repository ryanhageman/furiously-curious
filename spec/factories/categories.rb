# frozen_string_literal: true

FactoryBot.define do
  sequence(:category_name) { |n| "Category #{n}" }

  factory :category do
    name { generate(:category_name) }

    trait :invalid_category_name do
      name nil
    end
  end
end
