FactoryBot.define do

  factory :student do
    name { "abe" }
    sequence(:email) { |n| "#{n}@gmail.com" }
    grade {"2"}
    preference {"aa"}
    intro {"aa"}
    password { "00000000" }
    password_confirmation { "00000000" }
    
     after(:build,:create) do |student|
      student.avatar.attach(io: File.open('spec/fixtures/test.png'), filename: 'test.png', content_type: 'image/png')
     end

  end

  trait :invalid_student do
    name{ 1234}
  end
  trait :with_group do
    # 一人の生徒は1つまでgroupと紐づけられる
    after(:create){ |student| create(:connection, student_id: student.id)}
  end
  
  trait :with_apply do
    # 一人の生徒は1つまでgroupと紐づけられる
    after(:create){ |student| create(:apply, student_id: student.id)}
  end

end