FactoryGirl.define do
  factory :user do
    name {Faker::Name.name}
    email {Faker::Internet.safe_email(name)}
    password_digest BCrypt::Password.create("password")
  end

end
