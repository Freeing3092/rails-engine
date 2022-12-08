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
  
  factory :invoice_item, class: InvoiceItem do
    quantity {Faker::Number.within(range: 1..10)}
    unit_price {Faker::Number.within(range: 1000..10000)}
    association :item, factory: :item
    association :invoice, factory: :invoice
  end

  factory :invoice, class: Invoice do
    status { Faker::Base.sample(['Shipped', 'Packaged', 'In Progress'])}
    association :merchant, factory: :merchant
    association :customer, factory: :customer
  end

  factory :customer, class: Customer do
    first_name {Faker::Name.first_name}
    last_name {Faker::Name.last_name}
  end
end