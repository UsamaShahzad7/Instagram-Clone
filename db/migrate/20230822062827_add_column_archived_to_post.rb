class AddColumnArchivedToPost < ActiveRecord::Migration[7.0]
  def change
    add_column :posts, :archived , :integer, default: 0
  end
end
