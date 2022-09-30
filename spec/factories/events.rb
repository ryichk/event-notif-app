# frozen_string_literal: true

FactoryBot.define do
  factory :event do
    owner
    sequence(:name) { |i| "イベント名#{i}" }
    sequence(:place) { |i| "place#{i}" }
    sequence(:content) { |i| "content#{i}" }
    start_at { rand(1..30).days.from_now }
    end_at { start_at + rand(1..10).hours }
  end
end
