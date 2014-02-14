class AddQuickAccessToDomain < ActiveRecord::Migration
  def change
    add_column :domains, :quick_access, :boolean, default: true
  end
end
