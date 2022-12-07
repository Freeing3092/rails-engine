require 'faker'

FactoryBot.define do
  factory :merchant, class: Merchant do
    name {Faker::Name.name}
  end
  
  factory :item, class: Item do
    name {Faker::Commerce.product_name}
    description {Faker::Marketing.buzzwords}
    unit_price {Faker::Number.within(range: 1000..10000)}
    association :merchant, factory: :merchant
  end
end