Gem::Specification.new do |s|
  s.name = 'i18n-hygiene'
  s.version = '1.0.2'
  s.license = 'MIT'
  s.summary = "A linter for translation data in ruby applications"
  s.description = "Provides a configurable rake task that checks locale data for likely issues. Intended to be used in build pipelines to detect problems before they reach production"
  s.authors = [ "Eleanor Kiefel Haggerty", "Keith Pitty", "Nick Browne" ]
  s.email = "dev@theconversation.edu.au"
  s.files = `git ls-files -- lib/*`.split("\n")
  s.homepage = 'https://github.com/conversation/i18n-hygiene'
  s.has_rdoc = true
  s.extra_rdoc_files = ["README.md"]
  s.rdoc_options << "--title" << "i18n-hygiene documentation" << "--main" << "README.md"

  s.add_dependency 'i18n', ['~> 0.6', '>= 0.6.9']
  s.add_dependency 'parallel', '~> 1.3'
  s.add_dependency 'rainbow', '>= 1.99.1', '< 3.0'
  s.add_dependency 'rake', '>= 0.8.7'
  s.add_development_dependency 'rspec', '~> 3.0'
  s.add_development_dependency 'pry-nav'
end
