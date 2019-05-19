# frozen_string_literal: true

require 'thor'

module Shortlook
  class CLI < Thor
    include Thor::Actions

    Error = Class.new(StandardError)

    desc 'version', 'shortlook version'
    def version
      require_relative 'version'
      puts "v#{Shortlook::VERSION}"
    end
    map %w[--version -v] => :version

    def self.source_root
      File.dirname(__FILE__)
    end

    def self.destination_root
      File.dirname(__FILE__)
    end

    no_commands do
      def class_name
        @config[:class_name]
      end

      def bundle_id
        @config[:bundle_id]
      end

      def provider_bundle_id
        @config[:provider_bundle_id]
      end

      def name
        @config[:name]
      end

      def type
        @config[:type]
      end

      def author
        @config[:author]
      end

      def provider_name
        @config[:provider_name]
      end
    end

    desc 'provider NAME', 'Generate a scaffold ShortLook Provider'
    def provider(name)
      require_relative 'commands/provider'
      @config = Shortlook::Commands::Provider.new(name).execute

      directory('templates/provider', provider_name)
    end
  end
end
