# frozen_string_literal: true

FactoryBot.define do
  factory :movie do
    association :category
    title { 'Inception' }
    description { 'A good movie' }
    is_deleted { false }
    created_at { Time.zone.now - 2.hours }
    updated_at { Time.zone.now - 2.hours }
  end
end
