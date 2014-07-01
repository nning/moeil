class AddMxSetToDomain < ActiveRecord::Migration
  def change
    add_column :domains, :mx_set, :boolean, default: true
  end
end
