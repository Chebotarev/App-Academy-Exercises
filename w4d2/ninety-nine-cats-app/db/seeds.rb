# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Cat.create!(
birth_date: Date.today << 24,
color: "white",
name: "kiki",
sex: 'm',
description: 'Kiki is the best ever. He is white furred'
)

Cat.create!(
birth_date: Date.today << 60,
color: "orange",
name: "sunny",
sex: 'm',
description: 'Sunny was my first cat. He is a male'
)

Cat.create!(
birth_date: Date.today << 120 ,
color: "calico",
name: "Maranda",
sex: 'f',
description: 'Maranda is older than the mountains. She has digestion problems'
)

CatRentalRequest.create!(
cat_id: 1,
start_date: Date.today,
end_date: Date.today >> 2
)

# DIFFERENT CAT
CatRentalRequest.create!(
cat_id: 2,
start_date: Date.today >> 2,
end_date: Date.today >> 3
)

# OVERLAP with request 1
CatRentalRequest.create!(
cat_id: 1,
start_date: Date.today,
end_date: Date.today >> 2,
status: 'PENDING'
)

# NO OVERLAP
CatRentalRequest.create!(
cat_id: 1,
start_date: Date.today >> 20,
end_date: Date.today >> 22,
status: 'PENDING'
)

# OVERLAP with request 1
CatRentalRequest.create!(
cat_id: 1,
start_date: Date.today >> 1,
end_date: Date.today >> 3,
status: 'PENDING'
)
