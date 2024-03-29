### Development
[Full Changelog](https://github.com/conversation/i18n-hygiene/compare/v1.0.0...master)

### [1.3.0] - 2022-02-23

* Drop `git` dependency. Use system's `grep` instead `git grep`
* Fixes a bug where the `exclude_files` wouldn't work

### [1.2.0] - 2021-11-26

* Ignore interpolation check for excluded keys

### [1.1.0] - 2020-04-01

* Relax version requirement on i18n gem

### [1.0.2] - 2018-10-25

Bug fixes:

* Prevent greedy variable checker from raising spurious errors

### [1.0.1] - 2017-08-07

Enhancements:

* Stop ignoring keys prefixed with i18n in KeyUsageChecker (James Healy)

Bug fixes:

* Stop skipping common.greeting key (James Healy)
