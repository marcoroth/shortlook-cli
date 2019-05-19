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

      TYPES = [
        { name: 'Contact Photo', value: { name: 'ContactPhoto', display: 'Contact Photos', key: 'contact-photo' } },
        { name: 'Profile Picture', value: { name: 'ProfilePicture', display: 'Profile Pictures', key: 'profile-picture' } },
        { name: 'Photo', value: { name: 'Photo', display: 'Photos', key: 'photos' } },
        { name: 'Cover', value: { name: 'Cover', display: 'Covers', key: 'covers' } }
      ].freeze

      def initialize(name)
        @name = name
        @config = TTY::Config.new
        @config.append_path(Dir.home)

        begin
          @config.read("#{Dir.home}/.shortlook.yml")
          @author = @config.fetch(:author)
          @bundle_prefix = @config.fetch(:bundle_prefix)
        rescue TTY::Config::ReadError
          @config.filename = '.shortlook'
          @author = ENV['USER']
          @bundle_prefix = 'ch.marcoroth'
        end

        spinner = TTY::Spinner.new(":spinner Fetching Apps for '#{@name}'", format: :bouncing_ball)
        spinner.auto_spin

        url = "https://itunes.apple.com/search?limit=10&media=software&term=#{@name}"
        results = JSON.parse(LHC.get(url).body)['results']
        @choices = results.map { |r| { name: "#{r['trackName']} (#{r['bundleId']})", value: r } }
        spinner.stop
      end

      def execute(*)
        selected = prompt.select('Select the App you want to create a Provider for:', @choices)
        full_name = prompt.ask('What\'s the name of your provider:', default: selected['trackName'])
        type = prompt.select('Select the type of the provider:', TYPES)
        @author = prompt.ask('What\'s your name?', default: @author)
        @bundle_prefix = prompt.ask('What\'s your bundle identifier prefix:', default: @bundle_prefix)

        name = full_name.gsub(/\W/, '')
        bundle_id = selected['bundleId']
        provider_name = "ShortLook-#{name}"
        class_name = "#{name}#{type[:name]}Provider"
        provider_bundle_id = "#{@bundle_prefix}.shortlook.plugin.#{type[:key]}.#{name.downcase}"

        save_config

        {
          name: full_name,
          provider_name: provider_name,
          class_name: class_name,
          author: @author,
          type: type,
          bundle_id: bundle_id,
          provider_bundle_id: provider_bundle_id
        }
      rescue TTY::Reader::InputInterrupt
        puts "\nAborting..."
        exit(0)
      end

      def save_config
        @config.set(:author, value: @author)
        @config.set(:bundle_prefix, value: @bundle_prefix)
        @config.write(force: true)
      end
    end
  end
end
