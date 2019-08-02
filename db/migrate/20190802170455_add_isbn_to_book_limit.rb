class AddIsbnToBookLimit < ActiveRecord::Migration[5.2]
  def change
    add_column :books, :isbn, :integer, limit: 8
  end
end
