class AddKebabToMafraj < ActiveRecord::Migration
  def change
    add_column :mafrajs, :kebab, :integer, default: 0
  end
end
