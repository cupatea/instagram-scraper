class Types::Application::Query < Types::Base::Object
  field :viewer, Types::User, null: true
  def viewer
    context[:current_user]
  end

  # OBSERVATIONS
  field :observations, [Types::Observation], null: false, authorize!: true
  def observations
    context[:current_user].observations.preload(:observer, observee: :followers_data)
  end

  field :observation, Types::Observation, null: true, authorize!: true do
    argument :id, Integer, required: true
  end

  def observation(id:)
    context[:current_user].observations.find_by(id: id)
  end
end
