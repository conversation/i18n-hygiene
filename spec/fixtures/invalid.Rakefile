require "i18n"
require "i18n/hygiene"

I18n::Hygiene::RakeTask.new(:default) do |config|
  I18n.load_path = Dir["spec/fixtures/locales/*_invalid.yml"]
  I18n.backend.load_translations
  I18n.default_locale = :en_invalid

  config.directories = ["spec/fixtures/project/app", "spec/fixtures/project/lib"]
  config.primary_locale = :en_invalid
  config.locales = [:fr_invalid]
  config.concurrency = 1
end
