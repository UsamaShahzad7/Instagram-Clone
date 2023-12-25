# frozen_string_literal: true

module AvatarCreator
  extend ActiveSupport::Concern
  included do
    def name_creator
      profile = Profile.find_by(account_id: current_account.id)
      user_name_for_api = profile.user_name.gsub(' ', '+')
      api_url = "https://ui-avatars.com/api/?name=#{user_name_for_api}"
      response = HTTParty.get(api_url)

      return unless response.success?

      image_data = response.body
      image_filename = "#{user_name_for_api}_avatar.png"
      profile.profile_picture.attach(io: StringIO.new(image_data), filename: image_filename)
    end
  end
end
