class TranslateCommentsToUser < ActiveRecord::Migration[5.2]
  def change
    remove_column :books, :comments, :text
    add_column :users, :comments, :text
  end
end
