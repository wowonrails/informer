class HitCounterVk
  require 'rest-client'

  class << self

    def run
      get_user_status!
      counter!
    end

    def counter!
      user = VkUser.find_by(name: @user_name)

      if user.present? && Time.now - user.created_at < 24.hour.to_i

        unless user.online == @user_status
          user.update(online: @user_status)

          if user.online == 1
            user.update(time_start: user.updated_at)
          else
            user.update(time_finish: user.updated_at)

            user.times_per_day += user.time_finish - user.time_start - 780
            user.save
          end
        end

      elsif user.present? && Time.now - user.created_at >= 24.hour.to_i

        user.destroy
        user = VkUser.create(name: @user_name,
                             online: 0,
                             times_per_day: 0)
      else
        user = VkUser.create(name: @user_name,
                             online: 0,
                             times_per_day: 0)
      end

    end

    def get_user_status!
      response = RestClient.get 'https://api.vk.com/method/users.get?user_ids=262325748&fields=online&v=5.52', {accept: :json}
      hash = JSON.parse(response.body)
      @user_name = hash['response'][0]['first_name']
      @user_status = hash['response'][0]['online']
    end

    def send_email
      Rails.logger.info "----------------------------------------- sender run"

      user = VkUser.last
      VkWorker.perform_async(user.id)

      Rails.logger.info "----------------------------------------- sender end"
    end
  end
end
