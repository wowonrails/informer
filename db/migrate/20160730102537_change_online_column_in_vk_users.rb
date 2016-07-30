class ChangeOnlineColumnInVkUsers < ActiveRecord::Migration
  def change
    remove_column :vk_users, :online
    add_column :vk_users, :online, :boolean, default: false
  end
end
