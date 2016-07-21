class HitCounterMailer < ApplicationMailer

  def while_in_vkontact(user)
    Rails.logger.info "----------------------------------------- mailer run"

    @vk_user = user
    @user = User.first
    mail(to: @user.email,
      subject: "Время нахождения в VK: #{user.duration(user.times_per_day)}")

    Rails.logger.info "----------------------------------------- mailer end"
  end
end
