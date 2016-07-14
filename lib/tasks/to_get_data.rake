namespace :db do
  desc "To get data on the user visits the site VKontakte"
  task procrastination: :environment do
    HitCounterVk.run
  end

  desc "To send info about procrastination"
  task sender: :environment do
    HitCounterVk.send_email
  end
end
