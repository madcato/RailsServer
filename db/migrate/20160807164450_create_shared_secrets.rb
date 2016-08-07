class CreateSharedSecrets < ActiveRecord::Migration
  def change
    create_table :shared_secrets do |t|
      t.integer :id1
      t.integer :id2
      t.string :secret

      t.timestamps
    end
    add_index(:shared_secrets, [:id1, :id2], unique: true)
  end
end
