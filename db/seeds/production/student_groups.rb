(1..5).each do |n|
  StudentGroup.create!(
    student_id: n,
    group_id: n
  )
end
