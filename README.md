# i18n-hygiene [![Build Status](https://travis-ci.org/conversation/i18n-hygiene.svg?branch=master)](https://travis-ci.org/conversation/i18n-hygiene)

Provides rake tasks to help maintain your translations.

## Usage

Include the gem in your gemfile and bundle:

`gem 'i18n-hygiene'`

## Integrating with rake

Then, create a rake task with the desired configuration. For example, this will create a rake task called `i18n:hygiene`:

```ruby
namespace :i18n do
  I18n::Hygiene::RakeTask.new do |config|
    config.directories = ["app", "lib"]
  end
end

```

You can then run the rake task with:
```
bundle exec rake i18n:hygiene
```

You could also create separate rake tasks with different names and configurations, this may be useful if you are in the middle of rolling out a new locale:
```ruby
namespace :i18n do
  I18n::Hygiene::RakeTask.new(:hygiene_live) do |config|
    config.locales = [:fr]
  end

  I18n::Hygiene::RakeTask.new(:hygiene_wip) do |config|
    config.locales = [:es]
  end
end
```

Which could be run like:

```
bundle exec rake i18n:hygiene_live
bundle exec rake i18n:hygiene_wip
```

## Configuration

| Configuration | Description |
|---|---|
| `concurrency` | How many threads to use for key usage check (default is number of cores) |
| `directories` | Directories to search for key usage |
| `exclude_files` | Excludes files from key usage check |
| `file_extensions` | Only look in files with these extensions for key usage |
| `primary_locale` | Translations from other locales will be checked against this one |
| `locales` | Translations from these locales will be checked against the primary locale |
| `keys_to_exclude` | Exclude individual keys  |
| `scopes_to_exclude` | Exclude groups of keys |

Example using all configuration options:

```ruby
I18n::Hygiene::RakeTask.new do |config|
  config.concurrency = 16
  config.directories = ["app", "lib"]
  config.exclude_files = ["README.md"]
  config.file_extensions = ["rb", "jsx"]
  config.primary_locale = :en
  config.locales = [:ja, :kr]
  config.keys_to_exclude = [
    "my.dynamically.used.key",
    "another.dynamically.used.key"
  ]
  config.scopes_to_exclude = [
    "activerecord",
    "countries"
  ]
end

```

#### Without Rails

Using this gem without is possible, but you'll need to load the translations manually first.

```ruby
namespace :i18n do
  require 'i18n'
  require 'i18n/hygiene'

  I18n.load_path = Dir["locales/*.yml"]
  I18n.backend.load_translations

  I18n::Hygiene::RakeTask.new(:hygiene_live) do |config|
    config.directories = ["src"]
    config.locales = [:fr]
  end
end
```

## License

MIT
