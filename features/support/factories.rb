require 'factory_girl'

Factory.define :inquiry, :class => ::Refinery::Inquiry do |i|
  i.name "Refinery"
  i.email "refinery@cms.com"
  i.message "Hello..."
end
