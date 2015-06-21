class AddNiveauToMafraj < ActiveRecord::Migration
  def change
    add_column :mafrajs, :niveau, :integer, default: 1
  end
end
