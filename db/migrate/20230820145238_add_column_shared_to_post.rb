class AddColumnSharedToPost < ActiveRecord::Migration[7.0]
  def change
    add_column :posts, :shared,:string, default: nil
  end
end
