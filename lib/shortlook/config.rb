# frozen_string_literal: true

CONFIG_PATH = "#{Dir.home}/.shortlook.yml"

require 'forwardable'
require 'tty-config'

module Shortlook
  class Config
    extend Forwardable

    def_delegators :@config, :fetch, :set

    def initialize
      config.append_path(Dir.home)

      begin
        config.read("#{Dir.home}/.shortlook.yml")
      rescue TTY::Config::ReadError
        config.filename = '.shortlook'
        config.set(:author, value: ENV['USER'])
        config.set(:bundle_prefix, value: 'ch.marcoroth')
      end
    end

    def config
      @config ||= TTY::Config.new
    end

    def save!
      config.write(force: true)
    end
  end
end
