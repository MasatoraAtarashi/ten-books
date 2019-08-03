class AddInfoLinkToBooks < ActiveRecord::Migration[5.2]
  def change
    add_column :books, :info_link, :string
  end
end
