# Stamper

Stamper is a ruby library to explore mailboxes and read emails through adapter. Currently only an IMAP adapter is available.

## Installation

Stamper is not published as a gem yet, use git for development.

## Usage

Example in the Vagrant VM:
```
require 'stamper'

adapter = Stamper::Adapter::IMAPAdapter.new(
  host: 'localhost',
  user: 'vagrant',
  password: 'vagrant',
  ssl: {verify_mode: 0}
)
me = Stamper::Account.new(address: 'user.name@domain.tld', adapter: adapter)
inbox = me.subscribed_mailboxes.first
last_two_messages_subject = inbox.messages(results: 2).map{|message| message.subject}
```

## Test

Tests are configured to run into a vagrant VM (a local IMAP server must be installed and configured).

```
$> vagrant up
$> vagrant ssh
$vm> cd /vagrant
$vm> bundle exec rake test
```

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
