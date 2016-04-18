# JunitModel

A nicer way to interact with JUnit xml files.

# Features

* Merge multiple JUnit files.
* Convert back to XML
* A great interface to build other tools.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'junit_model'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install junit_model

## Usage

``` ruby
file_path = './tests.xml'
test_group = JunitModel::Parser.read_path(file_path) => JunitModel::TestGroup
test_group.passed? => true
test_group.test_count => 34
test_group.failure_count => 0
test_group.test_suites => [JunitModel::TestSuite]

merged_test_group = JunitModel::Merger.merge(test_group, other_test_group) => JunitModel::TestGroup
merged_test_group.test_count => 50
merged_test_group.passed? = false
merged_test_group.to_xml => String
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/iainsmith/junit_model. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

