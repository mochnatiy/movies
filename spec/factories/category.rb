FactoryBot.define do
  factory :category do
    title { 'Science Fiction' }
    created_at { Time.zone.now - 2.hours }
    updated_at { Time.zone.now - 2.hours }
  end
end
