# i18n-hygiene

Provides rake tasks to help maintain your translations.

## Usage

Include the gem in your gemfile.

More detailed instructions will be available when gem is published.

You'll now have access to some new rake tasks:

| Task | Description |
|---|---|
| `i18n:hygiene:all` | Runs all of the checks |
| `i18n:hygiene:check_key_usage` | Reports any translations that are unused |
| `i18n:hygiene:check_variables` | Reports any translations that have an incorrectly named or missing interpolated variables |
| `i18n:hygiene:check_entities` | Reports any translations that have HTML entities when they shouldn't |
| `i18n:hygiene:check_return_symbols` | Reports any translations that have a unicode return character in them |
| `i18n:hygiene:check_script_tags` | Reports any translations that have script tags in them |
