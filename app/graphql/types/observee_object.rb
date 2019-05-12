class Types::ObserveeObject < Types::Base::Union
  description 'Object that can be observed, e.g. InstagramUser'
  possible_types Types::InstagramUserObject


  def self.resolve_type(_object, _context)
    Types::InstagramUserObject
  end
end
