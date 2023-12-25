# frozen_string_literal: true

class ApplicationController < ActionController::Base
  before_action :authenticate_account!

  def check_activation_status
    if current_account.de_activated?
      redirect_to admins_status_path
    end
  end

  def restrict_admin
    if current_account.admin?
      redirect_to admins_path
    end
  end

  def restrict_user
    if current_account.users?
      redirect_to root_path
    end
  end
end
