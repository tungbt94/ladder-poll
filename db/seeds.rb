#
# bundle exec rake db:drop
# bundle exec rake db:migrate
# bundle exec rake db:seed
Staff.create!(
  id: 1,
  manager_id: 0,
  email: "A@vcc.vn",
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
  email: "B@vcc.vn",
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
  email: "C@vcc.vn",
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
  email: "D@vcc.vn",
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
  email: "E@vcc.vn",
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
  email: "F@vcc.vn",
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
  email: "G@vcc.vn",
  name: "G",
  key_person: "0",
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
  email: "H@vcc.vn",
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
  email: "J@vcc.vn",
  name: "J",
  key_person: "2",
  department: "admicro",
  division: "machine learning",
  actived: true,
  provider: "",
  uid: "",
  oauth_token: "",
)

Staff.create!(
  id: 11,
  manager_id: 10,
  email: "staff_11@vcc.vn",
  name: "staff_11",
  key_person: "0",
  department: "vcc",
  division: "vccloud",
  actived: true,
  provider: "",
  uid: "",
  oauth_token: "",
)

Staff.create!(
  id: 12,
  manager_id: 10,
  email: "staff_12@vcc.vn",
  name: "staff_12",
  key_person: "0",
  department: "vcc",
  division: "vccloud",
  actived: true,
  provider: "",
  uid: "",
  oauth_token: "",
)

Staff.create!(
  id: 13,
  manager_id: 11,
  email: "staff_13@vcc.vn",
  name: "staff_13",
  key_person: "0",
  department: "vcc",
  division: "vccloud",
  actived: true,
  provider: "",
  uid: "",
  oauth_token: "",
)

Staff.create!(
  id: 14,
  manager_id: 11,
  email: "staff_14@vcc.vn",
  name: "staff_14",
  key_person: "0",
  department: "vcc",
  division: "vccloud",
  actived: true,
  provider: "",
  uid: "",
  oauth_token: "",
)

Staff.create!(
  id: 15,
  manager_id: 13,
  email: "staff_15@vcc.vn",
  name: "staff_15",
  key_person: "0",
  department: "vcc",
  division: "vccloud",
  actived: true,
  provider: "",
  uid: "",
  oauth_token: "",
)

5.times do |i|
  poll_id = i
  content = "vote #{i}"
  staff_id = Faker::Number.between(1, 9)
  Poll.create!(
    id: poll_id,
    content: content,
    staff_id: staff_id
  )
  number_option = Faker::Number.between(1, 5)
  number_option.times do |n|
    option_id = poll_id * 5 + n
    Option.create!(
      id: option_id,
      poll_id: poll_id,
      content: Faker::Lorem.sentence(3),
      created_at: "",
      updated_at: ""
    )
    number_staff_voted = Faker::Number.between(0, 8)
    number_staff_voted.times do |s|
      StaffPoll.create!(
        staff_id: s+1,
        poll_id: poll_id,
        option_id: option_id
      )
    end
  end
end
