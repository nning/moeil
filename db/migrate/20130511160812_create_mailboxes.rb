class CreateMailboxes < ActiveRecord::Migration
  def change
    create_table :mailboxes do |t|
      t.string :username, null: false
      t.string :password, null: false
      t.string :name
      t.string :maildir, null: false
      t.integer :quota, default: 0
      t.boolean :active, default: true
      t.references :domain, null: false
      t.timestamps null: false
    end

    change_table :mailboxes do |t|
      t.index :username
      t.index [:username, :domain_id], unique: true
      t.index :domain_id
    end
  end
end
