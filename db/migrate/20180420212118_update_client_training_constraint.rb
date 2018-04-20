class UpdateClientTrainingConstraint < ActiveRecord::Migration[5.1]
  def change
    remove_foreign_key :trainings, :clients

    add_foreign_key :trainings, :clients, on_delete: :cascade
  end
end
