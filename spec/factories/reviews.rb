# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :review do
    product nil
    uid "MyString"
    permalink "MyString"
    name "MyString"
    keywords "MyString"
    blurb "MyText"
    body "MyText"
    state "MyString"
    type ""
    active_date "2013-02-26"
    deactivated_date "2013-02-26"
    user nil
    cached_tag_list "MyString"
  end
end
