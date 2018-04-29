module ApiEvents
  class Configuration
    attr_accessor :listeners

    def initialize
      @listeners = []
    end
  end
end
