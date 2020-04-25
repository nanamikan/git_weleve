FactoryBot.define do
  factory :apply do
    sequence(:event_id) { |n| n}
    sequence(:student_id) { |n| n}
    association :event
    association :student
  end
end