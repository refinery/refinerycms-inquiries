require 'factory_girl'

Factory.define :inquiry do |i|
  i.name "Refinery"
  i.email "refinery@cms.com"
  i.message "Hello..."
end
