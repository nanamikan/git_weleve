title_names = %w{パーティ スポーツ お花見 食事会 宅パ}
5.times do |n|
  Event.create!(
    title: title_names[n],
    date: Date.today.next_day(n),
    descrip: "説明",
    where: "場所",
    group_id: n+1
  )
  
end

