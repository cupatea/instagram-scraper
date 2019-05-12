class Types::Application::Query < Types::Base::Object
  field :viewer, Types::User, null: true
  def viewer
    context[:current_user]
  end

  # OBSERVATIONS
  field :observations, [Types::Observation], null: false, authorize!: true
  def observations
    context[:current_user].observations.preload(:observer, :observee)
  end

end
