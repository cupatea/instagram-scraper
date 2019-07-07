module Filterable
  extend ActiveSupport::Concern
  module ClassMethods
    def scope_filter params = {}
      scope = all
      params.each do |filter, value|
        scope_method = "filter_#{filter}".to_sym
        unless scope.respond_to?(scope_method)
          raise NoMethodError, "#{scope.klass} model doesn't have implemented scope `#{scope_method}'"
        end

        scope = scope.public_send(scope_method, value) if value.present? && value != "All"
      end
      scope
    end
  end
end
