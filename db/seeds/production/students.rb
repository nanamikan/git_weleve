10.times do |n|
  Student.create!(
    id: n+1,
    email: "#{n}@test.com",
    password: "password",
    password_confirmation: "password",
    grade: n % 5
  )
  
end

