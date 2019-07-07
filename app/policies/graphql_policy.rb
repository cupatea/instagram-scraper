class GraphqlPolicy
  attr_reader :object, :query

  def initialize(object, query)
    @object = object
    @query = query
  end

  def current_user?
    query.context[:current_user].present?
  end
end
