class AddIndexIsbn < ActiveRecord::Migration[5.2]
  def change
  end

  add_index :books, [:user_id, :isbn, :title], unique: true
end
