class CreateCoaches < ActiveRecord::Migration[5.1]
  def change
    create_table :coaches do |t|
      t.string :mailAddress
      t.string :password
      t.string :name
      t.string :lastname

      t.timestamps
    end
    add_index :coaches, :mailAddress, unique: true
  end
end

