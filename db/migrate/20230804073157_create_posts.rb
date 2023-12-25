# frozen_string_literal: true

class CreatePosts < ActiveRecord::Migration[7.0]
  def change
    create_table :posts do |t|
      t.text :caption
      t.string :location
      t.timestamps
    end
  end
end
