# Syro::Container

[![Gem](https://img.shields.io/gem/v/syro-container.svg)](https://rubygems.org/gems/syro-container)
[![Build Status](https://travis-ci.org/sagmor/syro-container.svg)](https://travis-ci.org/sagmor/syro-container)
[![Test Coverage](https://codeclimate.com/github/sagmor/syro-container/badges/coverage.svg)](https://codeclimate.com/github/sagmor/syro-container/coverage)
[![Code Climate](https://codeclimate.com/github/sagmor/syro-container/badges/gpa.svg)](https://codeclimate.com/github/sagmor/syro-container)
[![Inline docs](http://inch-ci.org/github/sagmor/mruby-cli.svg?branch=master)](http://inch-ci.org/github/sagmor/mruby-cli)

A Syro Deck extension that allows it to register and resolve routes from a container.

## Usage

Add this line to your application's Gemfile:

```ruby
gem 'syro-container'
```

Include it in your `Syro::Deck`

```ruby
require 'syro/container'

class MyApp < Syro::Deck
  include Syro::Container
end
```

Register your sub-apps in your container:

```ruby
subapp = Syro.new {
  # Your app code here
  on('innerpath') {
    get {
      res.write "Hello, world!"
    }
  }
}

MyApp.register('path', subapp)
```

Access your subapp from the main app:

```ruby
app = Syro.new(MyApp)

env = {
  "REQUEST_METHOD" => "GET",
  "PATH_INFO"      => "/subapp/innerpath"
}
p app.call(env)
```

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/sagmor/syro-container. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

