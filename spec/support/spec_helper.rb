def refinery_login
  let(:logged_in_user) { Refinery::Core::NilUser.new }
end

def ensure_on(path)
  visit(path) unless current_path == path
end

def making_an_inquiry (name, email, message)
  ensure_on(refinery.inquiries_new_inquiry_path)
  fill_in "Name", :with => name
  fill_in "Email", :with => email
  fill_in "Message", :with => message
  click_button "Send message"
end
