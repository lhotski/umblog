FactoryBot.define do
  factory :post do
    subject { FFaker::HipsterIpsum.sentence 5 }
    body { FFaker::HipsterIpsum.paragraph 3 }
    ip_address    { FFaker::Internet.ip_v4_address }
    factory :post_with_user do
      user
    end
  end
end