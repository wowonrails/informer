class HitCounterMailer < ApplicationMailer

  def while_in_vkontact(user)
    @vk_user = user
    @user = User.first
    mail(to: "Vladimir <#{@user.email}>",
      subject: "Время нахождения в VK: #{user.duration(user.times_per_day)}")
  end
end
