Gem::Specification.new do |s|
  s.name = 'i18n-hygiene'
  s.version = '0.0.0.pre'
  s.license = 'MIT'
  s.summary = ""
  s.description = "Provides rake tasks to help maintain translations."
  s.authors = [""]
  s.files = `git ls-files -- lib/*`.split("\n")
  s.homepage ='https://github.com/conversation/i18n-hygiene'

  s.add_dependency 'i18n', ['~> 0.6', '>= 0.6.9']
end
