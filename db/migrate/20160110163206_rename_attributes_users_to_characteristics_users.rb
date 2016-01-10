class RenameAttributesUsersToCharacteristicsUsers < ActiveRecord::Migration
  def change
     rename_table :attributes_users, :characteristics_users
  end
end
