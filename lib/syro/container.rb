require 'syro'
require 'dry/container'

require "syro/container/version"

class Syro # :nodoc:

  # Container module for `Syro::Deck`
  #
  # @example
  #     class MyApp < Syro::Deck
  #       include Syro::Container
  #     end
  #
  #     # then:
  #     MyApp.register('path', Syro.new {})
  #
  module Container
    def self.included(deck)
      deck.extend ClassMethods
    end

    # Overrides default `Syro::Deck` initialization to always fetch sub apps
    # from container
    #
    # @param before [#call] app routing block
    #
    def initialize(before)
      code = Proc.new do
        instance_eval(&before) if before
        resolve!
      end

      super(code)
    end

    # Manually resolve from container.
    #
    # Used when you want to add routes after the resolution
    #
    # @example
    #     class MyApp < Syro::Deck
    #       include Syro::Container
    #     end
    #
    #     Syro.new(MyApp) {
    #       resolve!
    #
    #       on('after') {
    #         # Whatever
    #       }
    #     }
    #
    def resolve!
      return if @resolved
      @resolved = true

      segment = self.path.curr.split('/')[1]
      app = self.class.container.resolve(segment)
      self.path.consume(segment)
      run(app)
    rescue Dry::Container::Error
    end

    # Class methods extended when {Syro::Container} is included
    module ClassMethods

      # Container accessor
      def container
        @container ||= Dry::Container.new
      end

      # Register an app into the container.
      #
      # @param path [String] Path component to register.
      # @param app [Syro] Syro app to register at the path.
      def register(path,app)
        container.register(path,app)
      end

    end
  end
end
