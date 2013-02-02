# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :location do
    company nil
    uid "MyString"
    permalink "MyString"
    name "MyString"
    keywords "MyString"
    blurb "MyText"
    state "MyString"
    type ""
    cached_tag_list "MyString"
    address "MyString"
    city "MyString"
    us_state "MyString"
    zipcode "MyString"
    lat "MyString"
    lng "MyString"
    phone "MyString"
  end
end
