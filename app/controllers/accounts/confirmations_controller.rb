# frozen_string_literal: true

module Accounts
  class ConfirmationsController < Devise::ConfirmationsController
    protected

    # The path used after confirmation.
    def after_confirmation_path_for(_resource_name, resource)
      token = resource.send(:set_reset_password_token)
      # redirecting to manually defined route and controller
      accounts_after_confirmation_path(resource, reset_password_token: token)
    end
  end
end
