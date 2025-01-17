require "factory_bot"

FactoryBot.define do
  factory :inquiry, class: "Refinery::Inquiries::Inquiry" do
    name { "Refinery" }
    email { "refinery@example.com" }
    message { "Hello..." }
  end
end
