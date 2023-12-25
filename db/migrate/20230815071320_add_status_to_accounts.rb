# frozen_string_literal: true

class AddStatusToAccounts < ActiveRecord::Migration[7.0]
  def change
    add_column :accounts, :status, :integer, default: 1
  end
end
