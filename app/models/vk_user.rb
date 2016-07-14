class VkUser < ActiveRecord::Base

  def duration(seconds)

    sec = seconds % 60
    minutes = seconds / 60
    min = minutes % 60
    hours = minutes / 60
    hour = hours % 24

    duration = hour.to_s + ' ч. '+ min.to_s + ' мин. ' + sec.to_s + ' сек.'
    return duration
  end
end
