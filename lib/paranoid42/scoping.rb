module Paranoid42
  module Scoping
    extend ActiveSupport::Concern

    module ClassMethods

      def not_deleted
        where(deleted_at: nil)
      end

      def only_deleted
        where.not(deleted_at: nil)
      end

    end
  end
end
