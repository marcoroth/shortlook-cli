# frozen_string_literal: true

module Shortlook
  class Types
    def self.all
      [
        { name: 'Contact Photo', value: { name: 'ContactPhoto', display: 'Contact Photos', key: 'contact-photo' } },
        { name: 'Profile Picture', value: { name: 'ProfilePicture', display: 'Profile Pictures', key: 'profile-picture' } },
        { name: 'Photo', value: { name: 'Photo', display: 'Photos', key: 'photos' } },
        { name: 'Cover', value: { name: 'Cover', display: 'Covers', key: 'covers' } }
      ]
    end
  end
end
