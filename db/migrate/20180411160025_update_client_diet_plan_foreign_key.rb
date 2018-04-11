class UpdateClientDietPlanForeignKey < ActiveRecord::Migration[5.1]
  def change

    remove_foreign_key :diet_plans, :clients

    add_foreign_key :diet_plans, :clients, on_delete: :cascade
  end
end


