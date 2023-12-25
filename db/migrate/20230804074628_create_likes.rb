# frozen_string_literal: true

class CreateLikes < ActiveRecord::Migration[7.0]
  def change
    create_table :likes do |t|
      t.string :email
      t.belongs_to :post, foreign_key: true
      t.timestamps
    end
  end
end
