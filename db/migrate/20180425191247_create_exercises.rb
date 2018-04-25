class CreateExercises < ActiveRecord::Migration[5.1]
  def change
    create_table :exercises do |t|
      t.string :name, null: false
      t.integer :category, null: false

      t.timestamps
    end
  end
end
