class FollowersDatumCreateWorker
  include Sidekiq::Worker
  sidekiq_options queue: 'default', retry: false

  def perform
    InstagramUser.all.each do |user|
      user.create_followers_datum_now logger: 'sidekiq'
    end
  end
end
