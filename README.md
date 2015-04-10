# Tset

Tset generates tests for your models in your Rails application.

## Why?

TDD is great, but sometimes you just want to write some codes.

Enter 'Development Driven Test'. Tset enables you to just write codes and worry about tests later.

## Installation

Run installation command.

```
gem install tset
```

OR if you are using bundler,

```ruby
gem 'tset', group: :development
```

Run `bundle`

## Usage

In your application root directory, run the generator.

```
tset generate model YOUR_MODEL_NAME
```

Tset will read your model and generate a test accordingly.

By default, the Tset will use RSpec. Help us add MiniTest support by contributing.

## Fact

* Tset is a test spelled backwards.

## Contributing

### TODO

* Help us improve Tset by adding more test rules located in translators.
* Support MiniTest.
* Support controllers.
