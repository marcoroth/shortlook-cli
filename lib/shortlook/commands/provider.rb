# frozen_string_literal: true

require 'lhc'
require 'json'
require 'thor'

require 'tty-spinner'
require 'tty-config'

require_relative '../command'

module Shortlook
  module Commands
    class Provider < Shortlook::Command
      include Thor::Actions

      def initialize(name)
        @name = name
      end

      def execute(*)
        config = TTY::Config.new
        spinner = TTY::Spinner.new(":spinner Fetching Apps for '#{@name}'", format: :bouncing_ball)
        spinner.auto_spin

        url = "https://itunes.apple.com/search?limit=10&media=software&term=#{@name}"
        results = JSON.parse(LHC.get(url).body)['results']
        choices = results.map { |r| { name: "#{r['trackName']} (#{r['bundleId']})", value: r } }

        types = [
          { name: 'Contact Photo', value: { name: 'ContactPhoto', display: 'Contact Photos', key: 'contact-photo' } },
          { name: 'Profile Picture', value: { name: 'ProfilePicture', display: 'Profile Pictures', key: 'profile-picture' } },
          { name: 'Photo', value: { name: 'Photo', display: 'Photos', key: 'photos' } },
          { name: 'Cover', value: { name: 'Cover', display: 'Covers', key: 'covers' } }
        ]

        spinner.stop

        begin
          config.read('config.yml')
          author = config.fetch(:author)
          bundle_prefix = config.fetch(:bundle_prefix)
        rescue TTY::Config::ReadError
          config.filename = 'config'
          author = ENV['USER']
          bundle_prefix = 'ch.marcoroth'
        end

        selected = prompt.select('Select the App you want to create a Provider for:', choices)
        name = prompt.ask('What\'s the name of your provider:', default: selected['trackName'])
        type = prompt.select('Select the type of the provider:', types)
        author = prompt.ask('What\'s your name?', default: author)
        bundle_prefix = prompt.ask('What\'s your bundle identifier prefix:', default: bundle_prefix)

        config.set(:author, value: author)
        config.set(:bundle_prefix, value: bundle_prefix)
        config.write

        bundle_id = selected['bundleId']
        provider_name = "ShortLook-#{name.delete(' ')}"
        class_name = "#{name.delete(' ')}#{type[:name]}Provider"
        provider_bundle_id = "#{bundle_prefix}.shortlook.plugin.#{type[:key]}.#{name.downcase.delete(' ')}"

        {
          name: name,
          provider_name: provider_name,
          class_name: class_name,
          author: author,
          type: type,
          bundle_id: bundle_id,
          provider_bundle_id: provider_bundle_id
        }
      end
    end
  end
end
