class AddContinentToDinosaur < ActiveRecord::Migration
  def change
    add_column :dinosaurs, :continent, :string
  end
end
