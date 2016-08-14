class AddDataToUser < ActiveRecord::Migration
  def change
    add_column :users, :name, :string
    add_column :users, :photo, :text
  end
end
