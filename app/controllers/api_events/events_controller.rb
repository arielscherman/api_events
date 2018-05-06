module ApiEvents
  class EventsController < ApplicationController
    # We should add authorization.
    skip_before_action :verify_authenticity_token

    def create
      binding.pry
    end
  end
end
