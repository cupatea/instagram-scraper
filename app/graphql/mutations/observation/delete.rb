class Mutations::Observation::Delete < ApplicationMutation
  description 'Deletes an observation of instagram user'

  argument :id, Integer, required: true

  field :errors,  [String], null: false
  field :success, Boolean,  null: false

  def resolve(id:)
    observation = context[:current_user].observations.find_by(id: id)
    if observation&.destroy
      success_mutation
    elsif observation
      failed_mutation(observation.errors.to_a)
    else
      failed_mutation(["Observation wasn't found"])
    end
  end
end
