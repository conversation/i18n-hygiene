require "i18n"
require "i18n/hygiene"

I18n::Hygiene::RakeTask.new(:default) do |config|
  I18n.load_path = Dir["spec/fixtures/locales/*_valid.yml"]
  I18n.backend.load_translations
  I18n.default_locale = :en_valid

  config.directories = ["spec/fixtures/project/app", "spec/fixtures/project/lib"]
  config.primary_locale = :en_valid
  config.locales = [:fr_valid]
  config.exclude_keys = ["translation.dynamic", "translation.ignored_key"]
  config.file_extensions = ["rb", "jsx"]
  config.concurrency = 1
end
