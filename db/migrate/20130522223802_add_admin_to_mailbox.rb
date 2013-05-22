class AddAdminToMailbox < ActiveRecord::Migration
  def change
    add_column :mailboxes, :admin, :boolean, default: false
  end
end
