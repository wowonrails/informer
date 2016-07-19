class VkWorker
  include Sidekiq::Worker

  def perform(user_id)
    Rails.logger.info "-------------------------------------Worker Start"

    user = VkUser.find(user_id)
    HitCounterMailer.while_in_vkontact(user).deliver

    Rails.logger.info "-------------------------------------Worker Finish"
  end
end
