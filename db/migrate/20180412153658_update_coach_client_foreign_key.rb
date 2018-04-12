class UpdateCoachClientForeignKey < ActiveRecord::Migration[5.1]
  def change
    remove_foreign_key :clients, :coaches

    add_foreign_key :clients, :coaches, on_delete: :cascade
  end
end
