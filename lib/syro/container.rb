require 'syro'
require 'dry/container'

require "syro/container/version"

class Syro
  module Container
    def self.included(deck)
      deck.extend ClassMethods
    end

    def initialize(before)
      code = Proc.new do
        instance_eval(&before) if before
        resolve!
      end

      super(code)
    end

    def resolve!
      return if @resolved
      @resolved = true

      segment = self.path.curr.split('/')[1]
      app = self.class.container.resolve(segment)
      self.path.consume(segment)
      run(app)
    rescue Dry::Container::Error
    end

    module ClassMethods

      def container
        @container ||= Dry::Container.new
      end

      def register(*args)
        container.register(*args)
      end

    end
  end
end
