# frozen_string_literal: true

class AddForeignKeyToPost < ActiveRecord::Migration[7.0]
  def change
    add_column :posts, :profile_id, :integer
    add_foreign_key :posts, :profiles
  end
end
