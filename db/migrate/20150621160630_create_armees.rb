class CreateArmees < ActiveRecord::Migration
  def change
    create_table :armees do |t|
      t.integer :mafraj_id
      t.integer :zamel, default: 0

      t.timestamps null: false
    end
  end
end
