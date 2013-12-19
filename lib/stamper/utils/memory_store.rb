module Stamper

  module Utils

    # Simple add in memory key/object storage functionalities
    class MemoryStore
      include Singleton

      attr_reader :pool

      def initialize
        reset
      end

      def set(key, object)
        pool[key] = object
        return object
      end

      def unset(key)
        pool.delete key
      end

      def get(key)
        pool[key]
      end

      def find(key)
        pool.has_key? key
      end

      def purge
        reset
      end

      private

      def reset
        @pool = {}
      end
    end
  end
end