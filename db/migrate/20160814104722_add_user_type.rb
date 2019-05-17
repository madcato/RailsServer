class AddUserType < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :userType, :int, default: 0
  end
end
