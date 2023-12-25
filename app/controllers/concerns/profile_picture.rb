# frozen_string_literal: true

module ProfilePicture
  extend ActiveSupport::Concern
  included do
    def current_profile_picture
      @current_profile = Profile.find_by(id: current_profile)
    end
  end
end
