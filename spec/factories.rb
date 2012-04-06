# By using the symbol ':user', we get Factory Girl to simulate the User model.
Factory.define :user do |user|
  user.name                  "Henri Hua"
  user.email                 "hh@mail.com"
  user.password              "pwgeneration"
  user.password_confirmation "pwgeneration"
end

Factory.sequence :name do |n|
  "Person #{n}"
end

Factory.sequence :email do |n|
  "person-#{n}@example.com"
end