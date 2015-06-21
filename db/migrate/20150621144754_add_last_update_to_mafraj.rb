class AddLastUpdateToMafraj < ActiveRecord::Migration
  def change
    add_column :mafrajs, :derniere_recolte_fumee, :datetime, default: Time.now
    add_column :mafrajs, :derniere_recole_the, :datetime, default: Time.now
  end
end
