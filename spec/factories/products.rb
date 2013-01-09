# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :product do
    brand nil
    uid "MyString"
    permalink "MyString"
    name "MyString"
    keywords "MyString"
    blurb "MyText"
    body "MyText"
    state "MyString"
    type ""
    active_date "2013-01-07"
    deactivated_date "2013-01-07"
    cover 1
    brand nil
    model_num "MyString"
    sku "MyString"
    sku_type "MyString"
    cached_tag_list "MyString"
  end
end
