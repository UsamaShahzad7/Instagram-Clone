# frozen_string_literal: true

  class Admins::AdminsController < ApplicationController

    # before_action :restrict_user
    layout 'flow'
    def index
      @profiles = Profile.all
      @posts = Post.all.order(created_at: :desc)
      @accounts = Account.where.not(role: 1)
    end

    def status
      @email = current_account.email
    end

    def de_activate
      account = Account.find_by(id: params[:account_id])
      account.update(status: 0)
      redirect_to admins_path
    end

    def activate
      account = Account.find_by(id: params[:account_id])
      account.update(status: 1)
      redirect_to admins_path
    end
  end
