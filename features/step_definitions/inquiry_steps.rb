Given /^I have no inquiries$/ do
  ::Refinery::Inquiry.delete_all
end

Then /^I should have ([0-9]+) inquiries?$/ do |count|
  ::Refinery::Inquiry.count.should == count.to_i
end

Given /^I have an? inquiry from "([^"]*)" with email "([^\"]*)" and message "([^\"]*)"$/ do |name, email, message|
  ::Refinery::Inquiry.create(:name => name,
                             :email => email,
                             :message => message)
  end

Given /^I have an? inquiry titled "([^"]*)"$/ do |title|
  ::Refinery::Inquiry.create(:name => title,
                             :email => 'test@cukes.com',
                             :message => 'cuking ...',
                             :spam => false)

  ::Refinery::Inquiry.create(:name => title,
                             :email => 'test@cukes.com',
                             :message => 'cuking ...',
                             :spam => true)
end
