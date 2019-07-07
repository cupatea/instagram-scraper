class Types::Observee < Types::Base::Union
  description 'Object that can be observed, e.g. InstagramUser'
  possible_types Types::InstagramUser

  def self.resolve_type(_object, _context)
    Types::InstagramUser
  end
end
