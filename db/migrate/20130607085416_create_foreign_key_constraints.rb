class CreateForeignKeyConstraints < ActiveRecord::Migration
  def change
    change_table :aliases do |t|
      t.foreign_key :domain, dependent: :delete
    end

    change_table :mailboxes do |t|
      t.foreign_key :domain, dependent: :delete
      t.foreign_key :relocation, dependent: :delete
    end

    change_table :relocations do |t|
      t.foreign_key :mailbox
    end
  end
end
