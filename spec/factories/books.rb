FactoryBot.define do
  factory :book do
    title "money ball"
    authors "michel"
    published_date "2015"
    image_link "fjwioejf"
    isbn "9784274067938"
    info_link "http://books.google.co.jp/books?id=ihd-mwEACAAJ&dq=%E3%83%9E%E3%83%8D%E3%83%BC%E3%83%9C%E3%83%BC%E3%83%AB&hl=&source=gbs_api"
    association :user
  end
end
