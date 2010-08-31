Gem::Specification.new do |s|
  s.platform    = Gem::Platform::RUBY
  s.name        = 'refinerycms-inquiries'
  s.version     = '0.9.8.3'
  s.summary     = 'Inquiry handling functionality for the Refinery CMS project.'
  s.required_ruby_version = '>= 1.8.7'
  s.description = "Inquiry handling functionality extracted from Refinery CMS to allow you to have a contact form and manage inquiries in the Refinery backend."
  s.homepage    = "http://refinerycms.com"
  s.email       = "info@refinerycms.com"
  s.authors     = ["Resolve Digital"]

  s.files        = Dir['app/**/*', 'config/**/*', 'readme.md', 'license.md', 'lib/**/*']
  s.require_path = 'lib'

  s.has_rdoc = true

  s.add_dependency('filters_spam', '~> 0.1')
  s.add_dependency('refinerycms',  '~> 0.9.8')
end
