class VkWorker
  include Sidekiq::Worker

  def perform(user_id)\
    Rails.loger.info "-------------------------------------Worker Start"

    user = VkUser.find(user_id)
    HitCounterMailer.while_in_vkontact(user).deliver

    Rails.loger.info "-------------------------------------Worker Finish"
  end
end
