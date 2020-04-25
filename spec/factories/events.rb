FactoryBot.define do
  # full_profile?がtrueのevent
  factory :event do
    title { "hoge" }
    date { Faker::Date.between(from: 2.days.ago, to: Date.today)}
    descrip {"aa"}
    where {"aa"}
    association :group
    after(:build,:create) do |event|
      event.image.attach(io: File.open('spec/fixtures/test.png'), filename: 'test.png', content_type: 'image/png')
     end
  end
  
  
  trait :invalid  do
    title { "invalid" }
    name{ 1234 }
  end
  
  
 
  # 複数のEVENT作成
  factory :event_index,class: Event do
    title { "hoge" }
    date {"0000-00-00"}
    descrip {"aa"}
    where{"aa"}
    sequence(:group_id) { |n| n}
    created_at { Faker::Time.between(1.month.ago, Time.now, :all) }
    
    after(:build,:create) do |event|
      event.image.attach(io: File.open('spec/fixtures/test.png'), filename: 'test.png', content_type: 'image/png')
     end
  end
end