FactoryBot.define do
  factory :group do
    name { "abc" }
    what_to_do {"bbb"}
    category {"aa"}
    intro {"aa"}
    after(:build,:create) do |group|
      group.image.attach(io: File.open('spec/fixtures/test.png'), filename: 'test.png', content_type: 'image/png')
    end
    
  end
end
