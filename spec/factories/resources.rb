# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do 
  factory :resource do
    name                    "example" 
    subject_list            "subject 1, subject 2"
    format_list             "format 1, format 2"
    description             "rails book"
    cost                    "1999"
    cost_type               "monthly"
    provider_list           "provider 1, provider 2"
    url                     "www.example.com"

    factory :resource_two do
      name                    "example2" 
      url                     "www.example2.com"
    end
  end
end