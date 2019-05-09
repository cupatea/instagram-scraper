class Mutations::Observation::Create < GraphQL::Schema::Mutation
  description 'Creates an observation of instagram user'

  argument :username, String, required: true

  field :observation, Types::ObservationObject,  null: true
  field :errors,      [String],                  null: false
  field :success,     Boolean,                   null: false

  def resolve(username:)
    observation = ::Observation.new(observer: context[:current_user],
                                    observee: InstagramUser.find_or_create_by(username: username))
    if observation.save
      { success: true,
        errors: [],
        observation: observation }
    else
      { success: false,
        errors: observation.errors.to_a,
        observation: nil }
    end
  end
end