# Tset

[![Build Status](https://travis-ci.org/sungwoncho/tset.svg?branch=master)](https://travis-ci.org/sungwoncho/tset)

Tset generates tests for your models in your Rails application.

## Why?

TDD is great, but sometimes you just want to write some codes.

Enter 'Development Driven Test'. Tset enables you to just write codes and worry about tests later.

## Installation

Run installation command.

```
gem install tset
```

---

*OR* if you want to use bundler,

```ruby
gem 'tset', group: :development
```

Run `bundle install`.

Append `bundle exec` when you run tset commands.

## Usage

In your application root directory, run the generator.

```
tset generate model YOUR_MODEL_NAME
```

Tset will read your model and generate a test accordingly.

If your model looks like the following,

```ruby
class Post < ActiveRecord::Base
  validates_presence_of :author
  validates_length_of :author, maximum: 30
  belongs_to :author
end
```

Tset will generate a spec file such as:

```ruby
require 'spec_helper'

describe Post do

  describe "associations" do
    it { is.expected_to belong_to(:author) }
  end

  describe "validations" do
    it { is.expected_to ensure_length_of(:author).is_at_most(30) }
    it { is.expected_to validate_presence_of(:author) }
  end
end
```

By default, the Tset will use RSpec. Help us add Minitest support by contributing.

## Dependency

You need [shoulda-matchers](https://github.com/thoughtbot/shoulda-matchers) to run some of tests Tset generates for you.

It lets you use matchers such as `validate_presence_of(:name)` in your spec.

## Architecture

There are four main objects at play: `Analyzer`, `Translator`, `Writer`, and `Generator`.

* Analyzer reads your model file, and matches any lines that are deemed 'testable'. It returns an array of `Tset::Testable` objects.

* Translator converts `Tset::Testable` objects into `Tset::Test` objects.

* Writer writes the actual test in the spec file, for each `Tset::Test` objects.

* Generator copies spec templates, groups all major components together, and responds to CLI.

## Random

Tset is a test spelled backwards.

## Contributing

Tset is in beta. We need your help to improve it.

### TODO

* Add more translation rules for testables (located in `tset/translators/rspec.rb`).
* Support Minitest.
* Support controllers.
