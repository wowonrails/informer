class HitCounterMailer < ApplicationMailer

  def while_in_vkontact(user)
    Rails.loger.info "-------------------------------------Mailer Start"

    @vk_user = user
    @user = User.first
    mail(to: "Vladimir <#{@user.email}>",
      subject: "Время нахождения в VK: #{user.duration(user.times_per_day)}")

    Rails.loger.info "-------------------------------------Mailer Finish"
  end
end
