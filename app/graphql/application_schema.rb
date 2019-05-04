class ApplicationSchema < GraphQL::Schema
  mutation(Types::Application::MutationType)
  query(Types::Application::QueryType)
end
