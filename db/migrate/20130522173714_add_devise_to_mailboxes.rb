class AddDeviseToMailboxes < ActiveRecord::Migration
  def self.up
    rename_column :mailboxes, :password, :encrypted_password
  end

  def self.down
    rename_column :mailboxes, :encrypted_password, :password
  end
end
