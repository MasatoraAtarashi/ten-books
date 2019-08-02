class AddCommentsToBooks < ActiveRecord::Migration[5.2]
  def change
    add_column :books, :comments, :text
  end
end
