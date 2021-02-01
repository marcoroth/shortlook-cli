# frozen_string_literal: true

require 'thor'
require 'tty-spinner'

require_relative '../command'
require_relative '../types'
require_relative '../config'
require_relative '../services/app_store'

module Shortlook
  module Commands
    class Provider < Shortlook::Command
      include Thor::Actions

      def config
        @config ||= Config.new
      end

      def initialize(name)
        spinner = TTY::Spinner.new(":spinner Fetching Apps for '#{name}'", format: :bouncing_ball)
        spinner.auto_spin
        @choices = Services::AppStore.search(name)
        spinner.stop
      end

      def execute(*)
        selected = prompt.select('Select the App you want to create a Provider for:', @choices)
        full_name = prompt.ask("What's the name of your provider:", default: selected['trackName'])
        type = prompt.select('Select the type of the provider:', Types.all)
        author = prompt.ask("What's your name?", default: config.fetch(:author))
        bundle_prefix = prompt.ask("What's your bundle identifier prefix:", default: config.fetch(:bundle_prefix))

        config.set(:author, value: author)
        config.set(:bundle_prefix, value: bundle_prefix)
        config.save!

        name = full_name.gsub(' ', '')

        {
          name: full_name,
          provider_name: "ShortLook-#{name}",
          class_name: "#{name}#{type[:name]}Provider",
          author: author,
          type: type,
          bundle_id: selected['bundleId'],
          provider_bundle_id: "#{bundle_prefix}.shortlook.plugin.#{type[:key]}.#{name.downcase}"
        }
      rescue TTY::Reader::InputInterrupt
        puts "\nAborting..."
        exit(0)
      end
    end
  end
end
