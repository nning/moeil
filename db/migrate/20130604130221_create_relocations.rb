class CreateRelocations < ActiveRecord::Migration
  def change
    create_table :relocations do |t|
      t.string :old_username, null: false
      t.string :old_domain, null: false
      t.references :mailbox, null: false
      t.timestamps null: false
    end

    change_table :relocations do |t|
      # There was no problem in SQLite and PostgreSQL with the length of the
      # index name but rails 4 tries to protect MySQL.
      begin
        t.index [:old_username, :old_domain, :mailbox_id], unique: true
      rescue ArgumentError
        t.index [:old_username, :old_domain, :mailbox_id], unique: true,
          name: 'index_relocations_on_complete_uniqueness'
      end
      t.index [:old_username, :old_domain], unique: true
      t.index :mailbox_id, unique: true
    end
  end
end
