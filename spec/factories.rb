FactoryGirl.define do
  factory :user do
    name "Aman"
    email "coool.aman@gmail.com"
    password "amanps"
    password_confirmation "amanps"
  end

  factory :micropost do
    user
    content "Test Content"
  end
end