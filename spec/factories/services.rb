FactoryBot.define do
  factory :service do
    imported_at { '2021-06-29 11:36:15' }
    latitude { 1.5 }
    longitude { 1.5 }
    name { 'MyString' }
    description { 'MyText' }
    phone { 'MyString' }
    email { 'user@mail.com' }
    publish_address { false }
    publish_telephone { false }
    charity_commission_id { 1 }
    address { 'MyString' }
    postcode { 'MyString' }
    website { 'MyString' }
  end
end
