FactoryGirl.define do
  factory :recipe do
    name { Faker::Commerce.product_name }
    instructions { Faker::Lorem.sentence }
  end

end
