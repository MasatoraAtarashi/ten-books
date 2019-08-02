class ChangeNameBooks < ActiveRecord::Migration[5.2]
  def change
    rename_column :books, :author, :authors
    rename_column :books, :image_url, :image_link
  end
end
