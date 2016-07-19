class HitCounterMailer < ApplicationMailer

  def while_in_vkontact(user)
    Rails.logger.info "-------------------------------------Mailer Start"

    @vk_user = user
    @user = User.first
    mail(to: @user.email,
      subject: "Время нахождения в VK: #{user.duration(user.times_per_day)}")

    Rails.logger.info "-------------------------------------Mailer Finish"
  end
end
