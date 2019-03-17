module UserConst
  extend ActiveSupport::Concern
  included do
    USERS_ALLOWED_PARAMS =
      %w[email gender email sign_in_count created_at confirmed_at current_sign_in_at
         last_sign_in_at current_sign_in_ip last_sign_in_ip online last_seen_at nickname].freeze

    INTERNAL_PARAMS =
      %w[encrypted_password reset_password_sent_at reset_password_token
         remember_created_at current_sign_in_at last_sign_in_at current_sign_in_ip
         last_sign_in_ip created_at updated_at failed_attempts unlock_token locked_at
         confirmation_token confirmed_at confirmation_sent_at].freeze
  end
end
