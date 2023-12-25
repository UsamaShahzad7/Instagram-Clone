# frozen_string_literal: true

class AddDefaultValueOfRoleToAccount < ActiveRecord::Migration[7.0]
  def change
    change_column_default :accounts, :role, from: nil, to: 0
  end
end
