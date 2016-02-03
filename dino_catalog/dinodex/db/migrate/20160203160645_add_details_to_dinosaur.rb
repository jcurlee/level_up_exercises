class AddDetailsToDinosaur < ActiveRecord::Migration
  def change
    add_column :dinosaurs, :name, :string
    add_column :dinosaurs, :period, :string
    add_column :dinosaurs, :diet, :string
    add_column :dinosaurs, :weight, :string
    add_column :dinosaurs, :walking, :string
    add_column :dinosaurs, :continent, :string
    add_column :dinosaurs, :description, :text
  end
end
