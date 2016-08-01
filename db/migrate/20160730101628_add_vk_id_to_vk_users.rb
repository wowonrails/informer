class AddVkIdToVkUsers < ActiveRecord::Migration
  def change
    add_column :vk_users, :vk_id, :string
  end
end
