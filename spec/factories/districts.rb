FactoryGirl.define do
  factory :district do
    name { Faker::Address.city }
    zip { Faker::Address.zip }
    graetzls { [FactoryGirl.create(:graetzl)] }
    area 'POLYGON ((0.0 0.0, 0.0 10.0, 10.0 10.0, 10.0 0.0, 0.0 0.0))'
  end
end
