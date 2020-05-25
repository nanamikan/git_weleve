group_names = %w{サークル1 パリピ みかん同好会 水泳体育会 バジリッサ}
category_names = %w{ サークル 体育会 同好会}

5.times do |n|
  Group.create!(
    id: n+1,
    name: group_names[n],
    category: category_names[n % 3],
    what_to_do: "すること",
    intro: "活動内容",
  )
  
end

