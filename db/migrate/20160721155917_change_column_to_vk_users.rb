class ChangeColumnToVkUsers < ActiveRecord::Migration
  def change
    change_column_default :vk_users, :online, 0
    change_column_default :vk_users, :times_per_day, 0
  end
end
