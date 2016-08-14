class AddUserType < ActiveRecord::Migration
  def change
    add_column :users, :userType, :int, default: 0
  end
end
