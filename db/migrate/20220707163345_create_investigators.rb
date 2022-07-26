class CreateInvestigators < ActiveRecord::Migration[7.0]
  def change
    create_table :investigators do |t|
      t.string :name
      t.integer :str
      t.integer :con
      t.integer :dex
      t.integer :int
      t.integer :siz
      t.integer :pow
      t.integer :app
      t.integer :edu

      t.timestamps
    end
  end
end
