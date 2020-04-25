FactoryBot.define do
  factory :connection do
    sequence(:group_id) { |n| n}
    sequence(:student_id) { |n| n}
    association :group
    association :student
  end
end
