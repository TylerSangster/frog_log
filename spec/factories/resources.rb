# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do 
  factory :resource do
    name                    "example" 
    subject                 "subject"
    format                  "book"
    description             "rails book"
    cost                    "1999"
    cost_type               "monthly"
    provider                "Hartl"
    url                     "www.example.com"

    factory :resource_two do
      name                    "example2" 
      subject                 "subject"
      format                  "book"
      description             "rails book"
      cost                    "1999"
      cost_type               "monthly"
      provider                "Hartl"
      url                     "www.example2.com"
    end
  end
end