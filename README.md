# i18n-hygiene [![Build Status](https://travis-ci.org/conversation/i18n-hygiene.svg?branch=master)](https://travis-ci.org/conversation/i18n-hygiene)

Provides rake tasks to help maintain your translations.

## Usage

Include the gem in your gemfile and bundle:

`gem 'i18n-hygiene'`

If you're using Rails, that's all there is to it. Instructions on how to use this gem without rails are further down.

You'll now have access to some new rake tasks:

| Task | Description |
|---|---|
| `i18n:hygiene:all` | Runs all of the checks |
| `i18n:hygiene:check_key_usage` | Reports any translations that are unused |
| `i18n:hygiene:check_variables` | Reports any translations that have an incorrectly named or missing interpolated variables |
| `i18n:hygiene:check_entities` | Reports any translations that have unexpected HTML entities |
| `i18n:hygiene:check_return_symbols` | Reports any translations that have a unicode return character in them |
| `i18n:hygiene:check_script_tags` | Reports any translations that have script tags in them |

#### Without Rails

Using this gem without Rails is intended to be possible, but it isn't very resilient to bare configurations yet. We hope to improve that.

You can still give it a try, you'll need to include this in your projects Rakefile:

```
require 'i18n/hygiene'
spec = Gem::Specification.find_by_name 'i18n-hygiene'
load "#{spec.gem_dir}/lib/tasks/i18n_hygiene.rake"
```

This should give you access to the above rake tasks.

## TO DO

* Add ability to white-list dynamically used keys e.g. `I18n.t(code, scope: "language.label")`.
* Enable keys that we want skipped to be configurable.
* Add ability to configure folders to scan for key usage.
* Detect duplicate keys like this, it's never what we expect and the results are confusing:

    foo:
      bar: 1
    foo:
      bar: 2
