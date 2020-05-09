class ApplicationMutation < GraphQL::Schema::Mutation
  def success_mutation hash = {}
    { success: true,
      errors: [] }.merge(hash)
  end

  def failed_mutation errors = [], hash = {}
    { success: false,
      errors: errors }.merge(hash)
  end
end
