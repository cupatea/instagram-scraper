class Types::Base::Object < GraphQL::Schema::Object
  field_class GraphQL::Pundit::Field
end
