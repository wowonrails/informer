class HitCounterVk
  require 'rest-client'

  class << self

    def run
      get_user_status!
      counter!
    end

    def counter!
      @responses.each do |vk_user|

        user = VkUser.find_by(name: vk_user["first_name"])

        if user.present? && Time.now - user.created_at < 24.hour.to_i

          unless user.online == vk_user["online"]
            user.update(online: vk_user["online"])

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
          user = VkUser.create(name: vk_user["first_name"])
        else
          user = VkUser.create(name: vk_user["first_name"])
        end
      end
    end

    def get_user_status!
      ids = ["262325748", "61606077"]
      urls = ids.map do |id|
        'https://api.vk.com/method/users.get?user_ids=' + id + '&fields=online&v=5.52'
      end

      @responses = urls.map do |url|
        response = RestClient.get url, {accept: :json}
        hash = JSON.parse(response.body)
        user = hash['response'][0]
      end
    end

    def send_email
      Rails.logger.info "----------------------------------------- sender run"

      users = VkUser.all

      users.each do |user|
        VkWorker.perform_async(user.id)
      end

      Rails.logger.info "----------------------------------------- sender end"
    end
  end
end
