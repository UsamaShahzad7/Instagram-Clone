# frozen_string_literal: true

class Account < ApplicationRecord

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable


  has_one :profile, dependent: :destroy

  enum role: { users: 0, admin: 1 }
  enum status: { de_activated: 0, activated: 1 }

  protected

  def password_required?
    confirmed? ? super : false
  end
end
