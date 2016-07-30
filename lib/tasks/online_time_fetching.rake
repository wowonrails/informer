namespace :db do
  desc "Fetches information about online status on VK"
  task fetch_online_status: :environment do
    VkAnalyzer.run
  end

  desc "Sends notification reports"
  task send_notification_reports: :environment do
    VkAnalyzer.send_email
  end
end
