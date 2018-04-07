class AddNonNullConstraintToClient < ActiveRecord::Migration[5.1]
  def change
    change_column_null :clients, :mail_address, false
    change_column_null :clients, :password, false
    change_column_null :clients, :name, false
    change_column_null :clients, :last_name, false
    change_column_null :clients, :mail_address, false
    change_column :clients, :is_pending, :boolean, default: true
  end
end