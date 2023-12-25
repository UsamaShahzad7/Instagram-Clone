# frozen_string_literal: true

class CreateProfiles < ActiveRecord::Migration[7.0]
  def change
    create_table :profiles do |t|
      t.string :user_name
      t.string :email
      t.belongs_to :account, foreign_key: true
      t.integer :status
      t.timestamps
    end
  end
end
