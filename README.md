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
    config.locales = [:es, :fr, :id]
    config.whitelist = [
      "my.dynamically.used.key",
      "another.dynamically.used.key"
    ]
  end
end

```

You could also create separate rake tasks with different configurations, this may be useful if you are in the middle of rolling out a new locale:
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
