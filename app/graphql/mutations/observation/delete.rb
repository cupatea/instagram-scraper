class Mutations::Observation::Delete < GraphQL::Schema::Mutation
  description 'Deletes an observation of instagram user'

  argument :id, Integer, required: true

  field :errors,  [String], null: false
  field :success, Boolean,  null: false

  def resolve(id:)
    observation = context[:current_user].observations.find_by(id: id)
    if observation&.destroy
      { success: true,
        errors: [] }
    elsif observation
      { success: false,
        errors: observation.errors.to_a }
    else
      { success: false,
        errors: ["Observation wasn't found"]}
    end
  end
end
