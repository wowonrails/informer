require 'rest-client'

class VkAnalyzer
  TARGET_IDS = ["262325748", "61606077"]
  VK_STATUS_CHANGE_GAP = 780

  class << self
    def run
      api_user_options_list.each do |vk_user_ops|
        user = VkUser.find_by(vk_id: vk_user_ops["id"])
        user = add_new_user!(vk_user_ops) if user.blank?

        check_new_day_started!(user)

        vk_status = vk_user_ops['online'] == "1" ? true : false

        if user_status_changed?(user, vk_status)
          user.online = vk_status

          if vk_status
            user.time_start = Time.zone.now
          else
            user.time_finish = Time.zone.now
            user.times_per_day += user.time_finish - user.time_start - VK_STATUS_CHANGE_GAP
          end

          user.save
        end
      end
    end

    def add_new_user!(vk_user_ops)
      VkUser.create!(
        vk_id: vk_user_ops["id"],
        name: vk_user_ops["first_name"]
      )
    end

    def check_new_day_started!(user)
      if user.updated_at.to_date < Date.today
        user.time_start = nil
        user.time_finish = nil
        user.times_per_day = 0

        user.save!
      end
    end

    def user_status_changed?(user, status)
      user.online != status
    end

    def prepare_urls
      TARGET_IDS.map do |id|
        [
          id,
          "https://api.vk.com/method/users.get?user_ids=#{id}&fields=online&v=5.52"
        ]
      end
    end

    def api_user_options_list
      prepare_urls.map do |data|
        response = RestClient.get data[1], {accept: :json}
        ops = JSON.parse(response.body)['response'][0]

        ops.merge({"id" => data[0]})
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
