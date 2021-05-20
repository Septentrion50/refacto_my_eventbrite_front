class ImagesController < ApplicationController
    def create
        @event = Event.find(params[:id])
        @event.image.attach(params[:image])
        redirect_to event_path(@event)
    end
end
