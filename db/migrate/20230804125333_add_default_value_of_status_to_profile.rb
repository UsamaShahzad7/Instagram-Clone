# frozen_string_literal: true

class AddDefaultValueOfStatusToProfile < ActiveRecord::Migration[7.0]
  def change
    change_column_default :profiles, :status, from: nil, to: 0
  end
end
