class EventsController < ApplicationController

  before_action :authenticate_user!, except: [:index, :show]
  before_action :event_creator?, only: [:edit, :update]

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
    @event = Event.find(params[:id])
  end

  def update
    @event = Event.find(params[:id])
    @start_date = DateTime.strptime(params[:start_date], "%Y-%m-%d")

    @event.update(
      start_date: @start_date,
      duration: params[:duration],
      location: params[:location],
      description: params[:description],
      title: params[:title],
      price: params[:price]
    )

    if @event.save
      redirect_to event_path(@event.id), notice: "Modification de l'événement effectuée"
    else
      p @event.errors.messages
      flash.now[:notice] = "Modification non prise en compte"
      render :edit
    end
  end

  def destroy
    @event = Event.find(params[:id])
    if @event.destroy
      redirect_to events_path, notice: "Suppression de l'événement effectuée"
    else
      flash.now[:notice] = "L'événement n'a pas pu être supprimé"
      render :edit
    end
  end

  private

  def event_creator?
    unless Event.find(params[:id]).organizer == current_user
      redirect_to events_path, notice: "Ce n'est pas votre événement"
    end
  end
end
