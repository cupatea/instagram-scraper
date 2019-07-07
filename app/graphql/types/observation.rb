class Types::Observation < Types::Base::Object
  description 'Observation object'

  field :id,             Integer,          null: false
  field :observer_type,  String,           null: false
  field :observer_id,    Integer,          null: false
  field :observee_type,  String,           null: false
  field :observee_id,    Integer,          null: false
  field :observer,       Types::Observer,  null: false
  field :observee,       Types::Observee,  null: false
end
