# frozen_string_literal: true

require 'lhc'
require 'json'

module Shortlook
  module Services
    class AppStore
      URL = 'https://itunes.apple.com/search'

      def self.search(name)
        params = { limit: 10, media: 'software', term: name }

        LHC.get(URL, params: params).data.results.map do |r|
          {
            name: "#{r['trackName']} (#{r['bundleId']})",
            value: r
          }
        end
      end
    end
  end
end
