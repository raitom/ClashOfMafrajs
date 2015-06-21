class CreateMafrajs < ActiveRecord::Migration
  def change
    create_table :mafrajs do |t|
      t.integer :user_id, null: false
      t.string :nom
      t.integer :theiere, default: 0
      t.integer :chicha, default: 0
      t.integer :the, default: 0
      t.integer :fumee, default: 0
      t.integer :zamel, default: 0
      t.integer :nigger, default: 1

      t.timestamps null: false
    end
  end
end
