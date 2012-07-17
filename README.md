# EmailAddressesParser

Parse a list of emails pasted into a web form, returning a hash with valid emails as keys and associated data (i.e. names) as values.
Pasted values can be comma or line separated.
Invalid values are returned in an array.

The default regular expression used for parsing can be overridden with an optional second argument.

Tested with Ruby 1.9.3 but should work with earlier versions.

## Installation

git clone git://github.com/victorgrey/email_addresses_parser.git
cd email_addresses_parser
gem build email_addresses_parser.gemspec
(sudo) gem install email_addresses_parser-x.x.x.gem

## Usage

valid_items_hash, invalid_items_array = EmailAddressesParser.parse_list(email_addresses_list)

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

## Copyright

Copyright (c) 2012 Victor Grey. See LICENSE for details.