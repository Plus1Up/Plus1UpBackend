class ChangeColumnName < ActiveRecord::Migration[5.1]
  def change
    rename_column :coaches, :mailAddress, :mail_address
    rename_column :coaches, :lastname, :last_name
  end
end
