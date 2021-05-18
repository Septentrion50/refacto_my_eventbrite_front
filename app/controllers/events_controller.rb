class EventsController < ApplicationController
  def index
    @events = Event.all
  end

  def show
    @event = Event.find(params[:id])
    @start_date = @event.start_date.to_date.strftime('%d %m %Y')
    @end_date = @event.end_date.to_date.strftime('%d %m %Y')
  end

  def new
  end

  def create
    @start_date = DateTime.strptime(params[:start_date], "%Y-%m-%d") 
    @event = Event.create(
      title: params[:title],
      description: params[:description],
      start_date: @start_date,
      duration: params[:duration],
      location: params[:location],
      price: params[:price].to_i,
      organizer: current_user
    )

    if @event.save
      redirect_to event_path(@event.id), alert: "Evènement créé avec succès"
    else
      p @event.errors.messages
      flash.now[:alert] = "Problème lors de la création de l'évènement"
      render :new
    end
  end

  def edit
  end

  def update
  end
end
