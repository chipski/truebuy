# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :photo do
    uid "MyString"
    permalink "MyString"
    name "MyString"
    keywords "MyString"
    blurb "MyText"
    state "MyString"
    type ""
    image_url "MyString"
    image_uid "MyString"
    image_name "MyString"
    topic nil
  end
end
