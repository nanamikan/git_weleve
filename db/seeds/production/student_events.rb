(1..5).each do |n|
  StudentEvent.create!(
    student_id: n,
    event_id: n
  )
end
