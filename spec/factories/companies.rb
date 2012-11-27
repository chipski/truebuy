# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :company do
    photo nil
    uid "MyString"
    permalink "MyString"
    name "MyString"
    keywords "MyString"
    blurb "MyText"
    body "MyText"
    state "MyString"
    type ""
    duns "MyString"
    url "MyString"
    url2 "MyString"
    cover 1
  end
end
