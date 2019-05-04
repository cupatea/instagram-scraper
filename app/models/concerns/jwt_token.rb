module JwtToken
  extend ActiveSupport::Concern

  def self.verify_token auth_token
    JsonWebToken.verify(auth_token, key: sekrit)
  end

  def generate_token
    payload = { id: uuid,
                expires_in: (Time.now.utc + expiry_hours.hour).to_i }

    JsonWebToken.sign(payload, key: sekrit)
  end


  private

  EXPIRY_HOURS = 5

  def expiry_hours
    Rails.application.secrets.expiry_hours || EXPIRY_HOURS
  end

  def sekrit
    Rails.application.secrets.secret_key_base
  end
end
