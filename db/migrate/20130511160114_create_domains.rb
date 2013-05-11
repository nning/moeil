class CreateDomains < ActiveRecord::Migration
  def change
    create_table :domains do |t|
      t.string :name, null: false
      t.string :description
      t.boolean :backupmx, default: false
      t.boolean :active, default: true
      t.timestamps null: false
    end

    change_table :domains do |t|
      t.index :name, unique: true
    end
  end
end
