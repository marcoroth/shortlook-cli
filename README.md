# Shortlook CLI

This is a CLI for scaffolding a ShortLook Provider

Learn more about ShortLook itself [here](https://dynastic.co/shortlook).

If you are looking for ShortLook providers you can find them [here](https://github.com/marcoroth?utf8=✓&tab=repositories&q=ShortLook-&type=&language=objective-c) or [here](https://repo.dynastic.co).

## Installation

This CLI runs on Ruby. Ensure you have Ruby installed before executing the following command:

    $ gem install shortlook

You can check if Ruby is installed with the following command

```
$ ruby -v
ruby 2.6.2p47 (2019-03-13 revision 67232) [x86_64-darwin18]
```

## Usage

The usage of the generator is pretty straight forward:

```bash
$ shortlook

Commands:
  shortlook help [COMMAND]  # Describe available commands or one specific command
  shortlook provider NAME   # Generate a scaffold ShortLook Provider
  shortlook version         # shortlook version
```

To start the Provider generator use the `provider` command followed by the search term of the app you want to build a provider for:

```
$ shortlook provider whatsapp

(    ● ) Fetching Apps for 'whatsapp'
Select the App you want to create a Provider for: (Use arrow keys, press Enter to select)
‣ WhatsApp Messenger (net.whatsapp.WhatsApp)
  WhatsApp Business (net.whatsapp.WhatsAppSMB)
  What's the Pic? - Hidden Object Puzzle Pictures (com.wtfapps.explorer1)
  Messenger for WhatsApp WebApp (com.limhong.messenger)
  Emoji Free – Emoticons Art and Cool Fonts Keyboard (goatmem.emoji)
  WatchUp - for WhatsApp (co.watchify.WatchUp2)

What's the name of your provider: (WhatsApp Messenger) __________

Select the type of the provider: (Use arrow keys, press Enter to select)
‣ Contact Photo
  Profile Picture
  Photo
  Cover

What's your name? (Marco Roth) __________

What's your bundle identifier prefix: (ch.marcoroth) __________

create  ShortLook-WhatsAppMessenger
create  ShortLook-WhatsAppMessenger/WhatsAppMessengerContactPhotoProvider.h
create  ShortLook-WhatsAppMessenger/WhatsAppMessengerContactPhotoProvider.m
create  ShortLook-WhatsAppMessenger/.gitignore
create  ShortLook-WhatsAppMessenger/Info.plist
create  ShortLook-WhatsAppMessenger/Makefile
create  ShortLook-WhatsAppMessenger/README.md
create  ShortLook-WhatsAppMessenger/ShortLook-API.h
create  ShortLook-WhatsAppMessenger/control


```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/marcoroth/shortlook-cli. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## Copyright

Copyright (c) 2019 Marco Roth. See [MIT License](LICENSE.txt) for further details.
