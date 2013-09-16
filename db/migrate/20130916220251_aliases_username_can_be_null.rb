class AliasesUsernameCanBeNull < ActiveRecord::Migration
  def up
    change_column_null :aliases, :username, true
  end

  def down
    change_column_null :aliases, :username, false
  end
end
