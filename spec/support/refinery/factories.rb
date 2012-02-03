FactoryGirl.define do
  factory :inquiry, :class => Refinery::Inquiries::Inquiry do
    name "Refinery"
    email "refinery@cms.com"
    message "Hello..."
  end
end
