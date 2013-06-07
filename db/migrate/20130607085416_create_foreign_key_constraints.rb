class CreateForeignKeyConstraints < ActiveRecord::Migration
  def change
    change_table :aliases do |t|
      t.foreign_key :domains, dependent: :delete
    end

    change_table :mailboxes do |t|
      t.foreign_key :domains, dependent: :delete
      t.foreign_key :relocations, dependent: :delete
    end

    change_table :relocations do |t|
      t.foreign_key :mailboxes
    end
  end
end
