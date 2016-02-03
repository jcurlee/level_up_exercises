class CreateDinosaurs < ActiveRecord::Migration
  def change
    create_table :dinosaurs do |t|

      t.timestamps null: false
    end
  end
end
