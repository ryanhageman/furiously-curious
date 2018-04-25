# frozen_string_literal: true

FactoryBot.define do
  sequence(:email) { |n| "name#{n}@email.com" }

  factory :user do
    email
    password 'password'
  end
end
