class Types::Application::QueryPolicy < GraphqlPolicy
  def observations?
    current_user?
  end

  def observation?
    current_user?
  end
end
