class EventsController < ApplicationController
  before_action :authenticate_user
  def index
    @events = current_user.events.all
  end

  def new
    @event = Event.new
  end
  
    def create
      @event = current_user.events.new(event_params)
      if @event.save
        flash[:notice] = "Event #{@event.name} successfully created"
        redirect_to events_path
      else
        flash[:alert] = "Something went wrong"
        render 'new'
      end
    end
    
    def edit
      current_event
    end
    
    def update
      current_event
      if @event.update(event_params)
        flash[:notice] = "Event successfully Updated!"
        redirect_to 'events_path'
      else
        flash[:alert] = "Something went wrong"
        render 'edit'
      end
    end
    
    def show
      current_event
    end

    def destroy
      current_event
      @name = @event.name
      @event.destroy
      respond_to do |format|
        format.html { redirect_to events_path, alert: "Event #{@name} was successfully deleted." }
      end
    end
    
    def current_event
      @event = Event.find(params[:id])
    end

    def event_params 
      params.require(:event).permit(:name)
    end
end
