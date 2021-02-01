# frozen_string_literal: true

require 'forwardable'

module Shortlook
  class Command
    extend Forwardable
    def_delegators :command, :run

    def execute(*)
      raise(NotImplementedError, "#{self.class}##{__method__} must be implemented")
    end

    def prompt(**options)
      require 'tty-prompt'
      TTY::Prompt.new(options)
    end
  end
end
