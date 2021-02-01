# frozen_string_literal: true

require 'thor'
require_relative 'provider_helpers'

module Shortlook
  class CLI < Thor
    include Thor::Actions

    def self.source_root
      File.dirname(__FILE__)
    end

    def self.destination_root
      File.dirname(__FILE__)
    end

    no_commands do
      include ProviderHelpers
    end

    desc 'version', 'shortlook version'
    def version
      require_relative 'version'
      puts "v#{Shortlook::VERSION}"
    end
    map %w[--version -v] => :version

    desc 'provider NAME', 'Generate a scaffold ShortLook Provider'
    def provider(name)
      require_relative 'commands/provider'
      @config = Shortlook::Commands::Provider.new(name).execute

      directory('templates/provider', provider_name)
    end
  end
end
