<!-- markdownlint-disable -->
<p align="center">
    <a href="https://github.com/DevelopersToolbox/">
        <img src="https://cdn.wolfsoftware.com/assets/images/github/organisations/developerstoolbox/black-and-white-circle-256.png" alt="DevelopersToolbox logo" />
    </a>
    <br />
    <a href="https://github.com/DevelopersToolbox/ssl-expiry-gem/actions/workflows/cicd.yml">
        <img src="https://img.shields.io/github/actions/workflow/status/DevelopersToolbox/ssl-expiry-gem/cicd.yml?branch=master&label=build%20status&style=for-the-badge" alt="Github Build Status" />
    </a>
    <a href="https://github.com/DevelopersToolbox/ssl-expiry-gem/blob/master/LICENSE.md">
        <img src="https://img.shields.io/github/license/DevelopersToolbox/ssl-expiry-gem?color=blue&label=License&style=for-the-badge" alt="License">
    </a>
    <a href="https://github.com/DevelopersToolbox/ssl-expiry-gem">
        <img src="https://img.shields.io/github/created-at/DevelopersToolbox/ssl-expiry-gem?color=blue&label=Created&style=for-the-badge" alt="Created">
    </a>
    <br />
    <a href="https://github.com/DevelopersToolbox/ssl-expiry-gem/releases/latest">
        <img src="https://img.shields.io/github/v/release/DevelopersToolbox/ssl-expiry-gem?color=blue&label=Latest%20Release&style=for-the-badge" alt="Release">
    </a>
    <a href="https://github.com/DevelopersToolbox/ssl-expiry-gem/releases/latest">
        <img src="https://img.shields.io/github/release-date/DevelopersToolbox/ssl-expiry-gem?color=blue&label=Released&style=for-the-badge" alt="Released">
    </a>
    <a href="https://github.com/DevelopersToolbox/ssl-expiry-gem/releases/latest">
        <img src="https://img.shields.io/github/commits-since/DevelopersToolbox/ssl-expiry-gem/latest.svg?color=blue&style=for-the-badge" alt="Commits since release">
    </a>
    <br />
    <a href="https://github.com/DevelopersToolbox/ssl-expiry-gem/blob/master/.github/CODE_OF_CONDUCT.md">
        <img src="https://img.shields.io/badge/Code%20of%20Conduct-blue?style=for-the-badge" />
    </a>
    <a href="https://github.com/DevelopersToolbox/ssl-expiry-gem/blob/master/.github/CONTRIBUTING.md">
        <img src="https://img.shields.io/badge/Contributing-blue?style=for-the-badge" />
    </a>
    <a href="https://github.com/DevelopersToolbox/ssl-expiry-gem/blob/master/.github/SECURITY.md">
        <img src="https://img.shields.io/badge/Report%20Security%20Concern-blue?style=for-the-badge" />
    </a>
    <a href="https://github.com/DevelopersToolbox/ssl-expiry-gem/issues">
        <img src="https://img.shields.io/badge/Get%20Support-blue?style=for-the-badge" />
    </a>
</p>

## Overview

This is a simple little gem for checking when an SSL will expire.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'ssl_expiry'
```

And then execute:

```
$ bundle
```

Or install it yourself as:

```
$ gem install ssl_expiry
```

## Usage

### Simple Usage
```ruby
require 'ssl_expiry'

SSLExpiry::SSLExpiry.check_certificates('wolfsoftware.com')

Results:
{"wolfsoftware.com"=>{"status"=>200, "expires_on"=>"02 Aug 2024", "expires_in"=>57, "common_name"=>"wolfsoftware.com", "issuer"=>"Let's Encrypt"}}
```

#### Multiple Domains

It is possible to check a list of domains rather than just single domains, this is done by passing a list[] to SSLExpiry::SSLExpiry.check_certificates.

```ruby
require 'ssl_expiry'

SSLExpiry::SSLExpiry.check_certificates(['wolfsoftware.com', 'wolfsoftware.net'])
```

### Displaying the output

```ruby
require 'ssl_expiry'

results = SSLExpiry::SSLExpiry.check_certificates('wolfsoftware.com')
SSLExpiry::SSLExpiry.display_results(results)
```

This would give the following output

```shell
----------------------------------------------------------------------------------------------------
 Domain                         | Status
----------------------------------------------------------------------------------------------------
 wolfsoftware.com               | expires on 02 Aug 2024 (in 57 days) [CN=wolfsoftware.com]
----------------------------------------------------------------------------------------------------
```

## Command Line Tools

There is a command line tool included with this gem.

```shell
check-ssl -d wolfsoftware.com

----------------------------------------------------------------------------------------------------
 Domain                         | Status
----------------------------------------------------------------------------------------------------
 wolfsoftware.com               | expires on 02 Aug 2024 (in 57 days) [CN=wolfsoftware.com]
----------------------------------------------------------------------------------------------------
```

### Multiple Domains

To check multiple domains at the same time, simply supply a comma separated list.

```shell
check-ssl -d wolfsoftware.com,wolfsoftware.net

------------------------------------------------------------------------------------------------------------------------
 Domain                         | Status
------------------------------------------------------------------------------------------------------------------------
 wolfsoftware.com               | expires on 02 Aug 2024 (in 57 days) [CN=wolfsoftware.com]
 wolfsoftware.net               | expires on 02 Aug 2024 (in 57 days) [CN=wolfsoftware.net]
------------------------------------------------------------------------------------------------------------------------
```

### Custom port

If you want to check an SSL expiry on a custom port you can do this by adding the port to the end of the domain.

```
  check-ssl -d wolfsoftware.com:8080
```

<br />
<p align="right"><a href="https://wolfsoftware.com/"><img src="https://img.shields.io/badge/Created%20by%20Wolf%20on%20behalf%20of%20Wolf%20Software-blue?style=for-the-badge" /></a></p>
