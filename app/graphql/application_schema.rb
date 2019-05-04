class ApplicationSchema < GraphQL::Schema
  mutation Types::Application::Mutation
  query    Types::Application::Query
end
