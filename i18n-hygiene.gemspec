Gem::Specification.new do |s|
  s.name        = 'i18n-hygiene'
  s.version     = '0.1.0'
  s.license     = 'MIT'
  s.summary     = "Helps maintain translations."
  s.description = "Provides rake tasks to help maintain translations."
  s.authors     = [ "Nick Browne"," Keith Pitty" ]
  s.email       = "dev@theconversation.edu.au"
  s.files       = `git ls-files -- lib/*`.split("\n")
  s.homepage    = 'https://github.com/conversation/i18n-hygiene'

  s.add_dependency 'i18n', ['~> 0.6', '>= 0.6.9']
  s.add_dependency 'parallel', '~> 1.3'
  s.add_development_dependency 'rspec', '~> 3.0'
end
