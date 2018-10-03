# frozen_string_literal: true

FactoryBot.define do
  sequence(:email) { |n| "name#{n}@email.com" }

  factory :user, aliases: [:author] do
    email
    password { 'password' }
    role { 0 }
  end

  trait :admin do
    role { 2 }
  end

  trait :author do
    role { 1 }
  end
end
