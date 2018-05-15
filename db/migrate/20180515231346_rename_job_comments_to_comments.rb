class RenameCommentsToComments < ActiveRecord::Migration[5.1]
  def change
    rename_table :comments, :comments
  end
end
