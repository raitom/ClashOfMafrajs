class CreateFileAttentes < ActiveRecord::Migration
  def change
    create_table :file_attentes do |t|
      t.integer :mafraj_id
      t.string :type_file
      t.text :message
      t.datetime :date_fin

      t.timestamps null: false
    end
  end
end
