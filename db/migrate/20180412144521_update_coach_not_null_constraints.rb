class UpdateCoachNotNullConstraints < ActiveRecord::Migration[5.1]
  def change
    change_column_null :coaches, :mail_address, false
    change_column_null :coaches, :password, false
    change_column_null :coaches, :name, false
    change_column_null :coaches, :last_name, false
  end
end