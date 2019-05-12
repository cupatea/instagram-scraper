class Types::Application::Query < Types::Base::Object
  field :viewer, Types::UserObject, null: true
  def viewer
    context[:current_user]
  end

  # OBSERVATIONS
  field :observations, [Types::ObservationObject], null: false, authorize!: true
  def observations
    context[:current_user].observations.preload(:observer, :observee)
  end

end
