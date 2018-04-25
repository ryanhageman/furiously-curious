# frozen_string_literal: true

FactoryBot.define do
  factory :post do
    author
    title 'Post Title'
    body 'I like to move it move it! You like to, MOVE IT!'
  end
end
