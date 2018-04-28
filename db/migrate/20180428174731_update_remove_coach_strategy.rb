class UpdateRemoveCoachStrategy < ActiveRecord::Migration[5.1]
  def change
    remove_foreign_key :exercises, :coaches

    add_foreign_key :exercises, :coaches, on_delete: :cascade
  end
end
