name = 'i18n_locales'
require "./lib/#{name}/version"

Gem::Specification.new name do |s|
  s.version = I18nLocales::VERSION
  s.summary = 'languages X country codes'
  s.authors = ['Barry Allard']
  s.email = 'barry.allard@gmail.com'
  s.homepage = "https://github.com/steakknife/#{name}"
  s.files = `git ls-files lib cache `.split("\n")
  s.license = 'MIT'
  s.require_paths = ['lib']

  s.add_development_dependency 'rake'
  s.add_development_dependency 'rspec-core'
  s.add_development_dependency 'yard'
end
.tap {|gem| pk = File.expand_path(File.join('~/.keys', 'gem-private_key.pem')); gem.signing_key = pk if File.exist? pk; gem.cert_chain = ['gem-public_cert.pem']} # pressed firmly by waxseal
