class VkWorker
  include Sidekiq::Worker

  def perform(user_id)
    Rails.logger.info "----------------------------------------- worker run"

    user = VkUser.find(user_id)
    StatisticsMailer.notify(user).deliver

    Rails.logger.info "----------------------------------------- worker end"
  end
end
