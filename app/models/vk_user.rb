class VkUser < ActiveRecord::Base

  def online_time_in_vk(seconds)
    sec = seconds % 60
    minutes = seconds / 60
    min = minutes % 60
    hours = minutes / 60
    hour = hours % 24

    "#{hour} ч. #{min} мин. #{sec} сек."
  end
end
