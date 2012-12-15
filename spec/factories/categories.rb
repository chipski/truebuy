# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :category do
    parent nil
    uid "MyString"
    permalink "MyString"
    name "MyString"
    keywords "MyString"
    blurb "MyText"
    body "MyText"
    state "MyString"
    type ""
    cover 1
    cached_tag_list "MyString"
  end
end
