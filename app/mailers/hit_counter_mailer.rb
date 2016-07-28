class HitCounterMailer < ApplicationMailer

  def while_in_vkontact(user)
    Rails.logger.info "----------------------------------------- mailer run"

    @vk_user = user
    @user = User.first

    # if user.name == "Valerija"
    #   recipients = [@user.email]
    #   recipients << "valerija-timofeeva@rambler.ru"
    # elsif user.name == "Mikhail"
    #   recipients = [@user.email]
    #   recipients << "moiseev-ma@yandex.ru"
    # else
      ecipients = [@user.email]
    # end

    Rails.logger.info "recipients---------------------- #{recipients.inspect}"

    mail(to: recipients,
      subject: "Время нахождения в VK: #{user.duration(user.times_per_day)}")

    Rails.logger.info "----------------------------------------- mailer end"
  end
end
