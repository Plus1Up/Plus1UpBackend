class CreateClients < ActiveRecord::Migration[5.1]
  def change
    create_table :clients do |t|
      t.references :coach, foreign_key: true
      t.string :mail_address
      t.string :password
      t.string :name
      t.string :last_name
      t.boolean :is_pending
      t.boolean :is_active

      t.timestamps
    end
  end
end
