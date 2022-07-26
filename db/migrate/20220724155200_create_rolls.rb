class CreateRolls < ActiveRecord::Migration[7.0]
  def change
    create_table :rolls do |t|
      t.string :target
      t.integer :rolled_value
      t.references :investigator, null: false, foreign_key: true

      t.timestamps
    end
  end
end
