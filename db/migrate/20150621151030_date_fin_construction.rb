class DateFinConstruction < ActiveRecord::Migration
  def change
    add_column :mafrajs, :date_fin_construction, :datetime
    add_column :mafrajs, :type_construction, :string
  end
end
