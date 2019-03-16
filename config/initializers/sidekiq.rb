Sidekiq.configure_server do |config|
  schedule_file = "config/sidekiq_schedule.yml"
  config.redis = { url: "redis://localhost:6379/", namespace: "instagram-scraper_#{Rails.env}" }

  if File.exists?(schedule_file) && Sidekiq.server?
    Sidekiq::Cron::Job.load_from_hash! YAML.load_file(schedule_file)
  end
end

Sidekiq.configure_client do |config|
  config.redis = { url: "redis://localhost:6379/", namespace: "instagram-scraper_#{Rails.env}" }
end
