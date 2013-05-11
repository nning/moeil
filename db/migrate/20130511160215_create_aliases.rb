class CreateAliases < ActiveRecord::Migration
  def change
    create_table :aliases do |t|
      t.string :address, null: false
      t.text :goto, null: false
      t.references :domain, null: false
      t.boolean :active, default: true
      t.timestamps null: false
    end

    change_table :aliases do |t|
      t.index :address, unique: true
      t.index :domain_id
    end
  end
end
