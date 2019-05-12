class Types::Token < Types::Base::Union
  description 'Object that can observe, e.g. User'
  possible_types Types::User

  def self.resolve_type(_object, _context)
    Types::User
  end
end
