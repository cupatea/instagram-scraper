class Types::Application::MutationPolicy < GraphqlPolicy
  def create_observation?
    current_user?
  end
end
