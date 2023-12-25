# frozen_string_literal: true

module CurrentProfile
  extend ActiveSupport::Concern
  included do
    def current_profile
      account_id = current_account.id
      profile = Profile.find_by(account_id:)
      profile.id
    end
  end
end
