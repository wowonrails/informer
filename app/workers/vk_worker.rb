class VkWorker
  include Sidekiq::Worker

  def perform(user_id)
    user = VkUser.find(user_id)
    HitCounterMailer.while_in_vkontact(user).deliver
  end
end
