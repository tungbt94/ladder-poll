# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
Staff.create!(
  id: 1,
  manager_id: 0,
  email: "A@vcc.com",
  name: "A",
  key_person: "4",
  department: "vcc",
  division: "vcc",
  actived: true,
  provider: "",
  uid: "",
  oauth_token: "",
)

Staff.create!(
  id: 2,
  manager_id: 1,
  email: "B@vcc.com",
  name: "B",
  key_person: "3",
  department: "vccloud",
  division: "solution",
  actived: true,
  provider: "",
  uid: "",
  oauth_token: "",
)

Staff.create!(
  id: 3,
  manager_id: 2,
  email: "C@vcc.com",
  name: "C",
  key_person: "2",
  department: "vccloud",
  division: "solution",
  actived: true,
  provider: "",
  uid: "",
  oauth_token: "",
)
Staff.create!(
  id: 4,
  manager_id: 2,
  email: "D@vcc.com",
  name: "D",
  key_person: "2",
  department: "vccloud",
  division: "solution",
  actived: true,
  provider: "",
  uid: "",
  oauth_token: "",
)

Staff.create!(
  id: 5,
  manager_id: 4,
  email: "E@vcc.com",
  name: "E",
  key_person: "1",
  department: "vccloud",
  division: "solution",
  actived: true,
  provider: "",
  uid: "",
  oauth_token: "",
)

Staff.create!(
  id: 6,
  manager_id: 4,
  email: "F@vcc.com",
  name: "F",
  key_person: "1",
  department: "vccloud",
  division: "solution",
  actived: true,
  provider: "",
  uid: "",
  oauth_token: "",
)

Staff.create!(
  id: 7,
  manager_id: 4,
  email: "G@vcc.com",
  name: "G",
  key_person: "1",
  department: "vccloud",
  division: "solution",
  actived: true,
  provider: "",
  uid: "",
  oauth_token: "",
)

Staff.create!(
  id: 8,
  manager_id: 1,
  email: "H@vcc.com",
  name: "H",
  key_person: "3",
  department: "admicro",
  division: "machine learning",
  actived: true,
  provider: "",
  uid: "",
  oauth_token: "",
)
Staff.create!(
  id: 9,
  manager_id: 8,
  email: "J@vcc.com",
  name: "J",
  key_person: "2",
  department: "admicro",
  division: "machine learning",
  actived: true,
  provider: "",
  uid: "",
  oauth_token: "",
)
