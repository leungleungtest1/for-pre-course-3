require 'faker'
Fabricator(:user) do
  name {Faker::Name.first_name}
  password "123456"
  email {Faker::Internet.email}
end