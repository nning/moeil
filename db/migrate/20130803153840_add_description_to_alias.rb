class AddDescriptionToAlias < ActiveRecord::Migration
  def change
    add_column :aliases, :description, :string
  end
end
