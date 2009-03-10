module Sunspot
  module DSL
    class Query
      def initialize(query)
        @query = query 
      end

      def keywords(keywords)
        @query.keywords = keywords
      end

      def with
        @conditions_builder ||= ::Sunspot::DSL::Scope.new(@query)
      end

      def without
        @negative_conditions_builder ||= ::Sunspot::DSL::Scope.new(@query, true)
      end

      def conditions
        @query.conditions
      end

      def paginate(options = {})
        page = options.delete(:page) || raise(ArgumentError, "paginate requires a :page argument")
        per_page = options.delete(:per_page)
        raise ArgumentError, "unknown argument #{options.keys.first.inspect} passed to paginate" unless options.empty?
        @query.paginate(page, per_page)
      end

      def order_by(field_name, direction = nil)
        @query.order_by(field_name, direction)
      end
    end
  end
end
