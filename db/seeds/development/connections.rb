(1..5).each  do |n|
  Connection.create!(
    student_id: n,
    group_id: n
  )
  
end
