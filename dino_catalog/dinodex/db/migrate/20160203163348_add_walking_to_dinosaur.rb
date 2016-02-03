class AddWalkingToDinosaur < ActiveRecord::Migration
  def change
    add_column :dinosaurs, :walking, :string
  end
end
