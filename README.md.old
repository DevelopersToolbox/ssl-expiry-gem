[![Build Status](https://img.shields.io/travis/AntiPhotonltd/ssl_expiry/master.svg)](https://travis-ci.org/AntiPhotonltd/ssl_expiry)
[![Software License](https://img.shields.io/badge/license-MIT-blue.svg)](LICENSE.md)
[![Release](https://img.shields.io/github/release/AntiPhotonltd/ssl_expiry.svg)](https://github.com/AntiPhotonltd/ssl_expiry/releases/latest)
[![Gem Version](https://badge.fury.io/rb/ssl_expiry.svg)](https://badge.fury.io/rb/ssl_expiry)
[![Github commits (since latest release)](https://img.shields.io/github/commits-since/AntiPhotonltd/ssl_expiry/latest.svg)](https://github.com/AntiPhotonltd/ssl_expiry/commits)
[![GitHub repo size in bytes](https://img.shields.io/github/repo-size/AntiPhotonltd/ssl_expiry.svg)](https://github.com/AntiPhotonltd/ssl_expiry)
[![GitHub contributors](https://img.shields.io/github/contributors/AntiPhotonltd/ssl_expiry.svg)](https://github.com/AntiPhotonltd/ssl_expiry)

# SSL Expiry

This is a simple little gem for checking when an SSL will expire.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'ssl_expiry'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install ssl_expiry

## Usage

### Simple Usage
```ruby
  require 'ssl_expiry'

  SSLExpiry::SSLExpiry.check_certificates('antiphoton.com')

  Results:
  {"antiphoton.com"=>{"status"=>200, "expires_on"=>"09 Mar 2019", "expires_in"=>16, "common_name"=>"antiphoton.com", "issuer"=>"COMODO CA Limited"}}
```

### Displaying the output

```ruby
  require 'ssl_expiry'

  results = SSLExpiry::SSLExpiry.check_certificates(['antiphoton.com','wolfsoftware.com'])
  SSLExpiry::SSLExpiry.display_results(results)
```

This would give the following output

```shell
  ----------------------------------------------------------------------------------------------------
   Domain                         | Status
  ----------------------------------------------------------------------------------------------------
   antiphoton.com                 | expires on 09 Mar 2019 (in 16 days) [CN=antiphoton.com]
   wolfsoftware.com               | expires on 12 Sep 2019 (in 203 days) [CN=*.wolfsoftware.com]
  ----------------------------------------------------------------------------------------------------
```

## Command Line Tools

There is a command line tool included with this gem.

```shell
  check-ssl -d antiphoton.com

  ----------------------------------------------------------------------------------------------------
   Domain                         | Status
  ----------------------------------------------------------------------------------------------------
   antiphoton.com                 | expires on 09 Mar 2019 (in 16 days) [CN=antiphoton.com]
  ----------------------------------------------------------------------------------------------------
```

### Custom port

If you want to check an SSL expiry on a custom port you can do this by adding the port to the end of the domain.

```
  check-ssl -d antiphoton.com:8080
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Testing

For local testing make sure that you run `bundle exec rspec spec` and then `rake install` to install the gem locally.

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/AntiPhotonltd/ssl_expiry. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the SSLExpiry project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/AntiPhotonltd/ssl_expiry/blob/master/CODE_OF_CONDUCT.md).
