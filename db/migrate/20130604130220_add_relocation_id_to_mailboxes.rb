class AddRelocationIdToMailboxes < ActiveRecord::Migration
  def change
    add_column :mailboxes, :relocation_id, :integer
  end
end
