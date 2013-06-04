class CreateRelocations < ActiveRecord::Migration
  def change
    create_table :relocations do |t|
      t.string :old_username, null: false
      t.string :old_domain, null: false
      t.references :mailbox, null: false
      t.timestamps null: false
    end

    change_table :relocations do |t|
      t.index [:old_username, :old_domain, :mailbox_id], unique: true
      t.index [:old_username, :old_domain], unique: true
      t.index :mailbox_id, unique: true
    end
  end
end
