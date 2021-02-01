# frozen_string_literal: true

module Shortlook
  module ProviderHelpers
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
end
