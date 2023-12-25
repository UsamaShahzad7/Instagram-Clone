# frozen_string_literal: true

module Accounts
  class RegistrationsController < Devise::RegistrationsController
    layout 'flow'
    # The path used after sign up for inactive accounts.
    def after_inactive_sign_up_path_for(_resource)
      accounts_confirmation_pending_path
    end
  end
end
