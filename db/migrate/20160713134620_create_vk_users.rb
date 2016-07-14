class CreateVkUsers < ActiveRecord::Migration
  def change
    create_table :vk_users do |t|
      t.string   :name
      t.integer  :online
      t.datetime :initial
      t.datetime :time_start
      t.datetime :time_finish
      t.integer  :times_per_day

      t.timestamps null: false
    end
  end
end
