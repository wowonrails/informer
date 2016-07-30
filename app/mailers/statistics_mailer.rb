class StatisticsMailer < ApplicationMailer

  def notify(user)
    Rails.logger.info "----------------------------------------- mailer run"

    @vk_user = user
    @user = User.first

    recipients = [@user.email]

    recipients << if user.name == "Valerija"
      "valerija-timofeeva@rambler.ru"
    elsif user.name == "Mikhail"
      "moiseev-ma@yandex.ru"
    end

    Rails.logger.info "recipients---------------------- #{recipients.inspect}"

    mail(to: recipients,
         subject: "Время нахождения в VK: #{user.online_time_in_vk(user.times_per_day)}")

    Rails.logger.info "----------------------------------------- mailer end"
  end
end
