def refinery_login
  let(:logged_in_user) { Refinery::Core::NilUser.new }
end

def ensure_on(path)
  visit(path) unless current_path == path
end

