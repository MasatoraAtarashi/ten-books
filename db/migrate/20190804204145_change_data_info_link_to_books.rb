class ChangeDataInfoLinkToBooks < ActiveRecord::Migration[5.2]
  def change
    change_column :books, :info_link, :text
  end
end
