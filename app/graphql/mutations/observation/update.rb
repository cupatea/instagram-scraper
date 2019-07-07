class Mutations::Observation::Update < GraphQL::Schema::Mutation
  description 'Update an observation of instagram user'

  argument :id,          Integer, required: true
  argument :observee_id, Integer, required: true

  field :errors,      [String],                   null: false
  field :success,     Boolean,                    null: false
  field :observation, Types::Observation,   null: true
  field :observee,    Types::InstagramUser, null: true

  def resolve(id:, observee_id:)
    observation = context[:current_user].observations.find_by(id: id)
    observee    = ::InstagramUser.find_by(id: observee_id)
    if observee && observation&.update(observee_id: observee.id)
      { success: true,
        observation: observation,
        observee: observee,
        errors: [] }
    elsif observee && observation
      { success: false,
        observation: observation,
        observee: observee,
        errors: observation.errors.to_a }
    else
      { success: false,
        observation: observation,
        observee: observee,
        errors: ["Observation or observee wasn't found"]}
    end
  end
end
