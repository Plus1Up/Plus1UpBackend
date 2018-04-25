class CreateTrainings < ActiveRecord::Migration[5.1]
  def change
    create_table :trainings do |t|
      t.string :name, null: false
      t.integer :weekday, null: false
      t.references :client, foreign_key: true

      t.timestamps
    end
  end
end
