# frozen_string_literal: true

FactoryBot.define do
  sequence(:username) { |n| "username#{n}" }

  factory :profile do
    user
    username

    trait :first_name do
      first_name 'Firstname'
    end

    trait :last_name do
      last_name 'Lastname'
    end

    trait :bio do
      bio 'I like to move it move it!'
    end

    trait :full_profile do
      first_name 'Firstname'
      last_name 'LastName'
      bio 'I like to move it move it!'
    end
  end
end
