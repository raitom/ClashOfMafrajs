class AddRecolteToMafraj < ActiveRecord::Migration
  def change
    add_column :mafrajs, :the_a_recolter, :float, default: 0
    add_column :mafrajs, :fumee_a_recolter, :float, default: 0
  end
end
