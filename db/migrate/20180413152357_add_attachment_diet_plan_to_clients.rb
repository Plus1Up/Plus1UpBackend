class AddAttachmentDietPlanToClients < ActiveRecord::Migration[5.1]
  def self.up
    change_table :clients do |t|
      t.attachment :diet_plan
    end
  end

  def self.down
    remove_attachment :clients, :diet_plan
  end
end
