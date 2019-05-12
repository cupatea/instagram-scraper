class Types::ObserverObject < Types::Base::Union
  description 'Object that can observe, e.g. User'
  possible_types Types::UserObject

  def self.resolve_type(_object, _context)
    Types::UserObject
  end
end
