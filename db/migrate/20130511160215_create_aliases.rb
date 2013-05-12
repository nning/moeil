class CreateAliases < ActiveRecord::Migration
  def change
    create_table :aliases do |t|
      t.string :username, null: false
      t.references :domain, null: false
      t.text :goto, null: false
      t.boolean :active, default: true
      t.timestamps null: false
    end

    change_table :aliases do |t|
      t.index [:username, :domain_id], unique: true
      t.index :domain_id
    end
  end
end
