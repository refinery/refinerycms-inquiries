# Encoding: UTF-8
require 'date'

Gem::Specification.new do |s|
  s.name              = %q{refinerycms-inquiries}
  s.version           = %q{2.1.0.dev}
  s.date              = Date.today.strftime("%Y-%m-%d")
  s.summary           = %q{Inquiry handling functionality for the Refinery CMS project.}
  s.description       = %q{Inquiry handling functionality extracted from Refinery CMS to allow you to have a contact form and manage inquiries in the Refinery backend.}
  s.homepage          = %q{http://refinerycms.com}
  s.email             = %q{info@refinerycms.com}
  s.authors           = ['Uģis Ozols', 'Philip Arndt', 'Rob Yurkowski']
  s.require_paths     = %w(lib)
  s.license           = %q{MIT}

  s.files             = `git ls-files`.split("\n")
  s.test_files        = `git ls-files -- spec/*`.split("\n")

  s.add_dependency  'refinerycms-core',     '~> 2.1.0.dev'
  s.add_dependency  'refinerycms-settings', '~> 2.1.0.dev'
  s.add_dependency  'filters_spam',         '~> 0.2'
end
