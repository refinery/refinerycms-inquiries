# Encoding: UTF-8

Gem::Specification.new do |s|
  s.name            = %q{refinerycms-inquiries}
  s.version         = %q{4.1.0}
  s.summary         = %q{Inquiry handling functionality for the Refinery CMS project.}
  s.description     = %q{Inquiry handling functionality extracted from Refinery CMS to allow you to have a contact form and manage inquiries in the Refinery backend.}
  s.homepage        = %q{http://refinerycms.com}
  s.email           = %q{info@refinerycms.com}
  s.authors         = ['Uģis Ozols', 'Philip Arndt', 'Rob Yurkowski']
  s.require_paths   = %w(lib)
  s.license         = %q{MIT}

  s.files           = `git ls-files`.split("\n")
  s.test_files      = `git ls-files -- spec/*`.split("\n")

  s.add_dependency  'refinerycms-core',     '~> 4.1'
  s.add_dependency 'rails', '~>6.0.0'
  s.add_dependency  'mobility'
  s.add_dependency  'refinerycms-settings', '~> 4.0'
  s.add_dependency  'filters_spam',         '~> 0.2'
  s.add_dependency  'actionmailer',        ['>= 5.1.0', '< 7']
  s.add_dependency  'httpclient'

  s.cert_chain      = [File.expand_path("../certs/parndt.pem", __FILE__)]
  if $0 =~ /gem\z/ && ARGV.include?("build") && ARGV.include?(__FILE__)
    s.signing_key = File.expand_path("~/.ssh/gem-private_key.pem")
  end
end
