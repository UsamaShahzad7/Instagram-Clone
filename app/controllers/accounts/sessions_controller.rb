# frozen_string_literal: true

module Accounts
  class SessionsController < Devise::SessionsController
    layout 'flow'
  end
end
