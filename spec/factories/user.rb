FactoryGirl.define do
  factory :user do
    name "Some Name"
    email "somename@gmail.com"
    password "12345"
    subscribed nil
  end
end
