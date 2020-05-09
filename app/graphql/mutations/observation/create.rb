class Mutations::Observation::Create < ApplicationMutation
  description 'Creates an observation of instagram user'

  argument :username, String, required: true

  field :observation, Types::Observation,   null: true
  field :observee,    Types::InstagramUser, null: false
  field :errors,      [String],             null: false
  field :success,     Boolean,              null: false

  def resolve(username:)
    observee    = ::InstagramUser.find_or_create_by(username: username)
    observation = ::Observation.new(observer: context[:current_user],
                                    observee: observee)
    if observation.save
      success_mutation(observation: observation, observee: observee)
    else
      failed_mutation(observation.errors.to_a, observation: nil, observee: observee)
    end
  end
end
