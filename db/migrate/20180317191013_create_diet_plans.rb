class CreateDietPlans < ActiveRecord::Migration[5.1]
  def change
    create_table :diet_plans do |t|
      t.references :client, foreign_key: true
      t.string :name
      t.string :file_path

      t.timestamps
    end
  end
end
