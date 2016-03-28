class RenameCommentTypeToDescription < ActiveRecord::Migration
  def change
    rename_column :comments, :comment_type, :category
  end
end
