class InvitationsController < ApplicationController
  def new
    @invitation = Invitation.new
    @events = current_user.events
  end

  def create
    event_id = params[:invitation][:event_id]
    
    unless event_id
      flash[:alert] = 'Invalid event'
      redirect_to events_path and return
    end

    if Invitation.where(invite_params).any?
      flash[:alert] = 'Already attending this event'
      redirect_to event_path(event_id) and return
    end

    unless current_user.events.include? Event.find(event_id)
      flash[:alert] = 'Only creators can invite to event'
      redirect_to event_path(event_id) and return
    end

    @invitation = Invitation.new(invite_params)
    if @invitation.save
      redirect_to event_path(event_id)
    else
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    @invitation = Invitation.find(params[:id])
    event = @invitation.event
    @invitation.destroy
    redirect_to event
  end

  private

  def invite_params
    params.require(:invitation).permit(:event_id, :user_id)
  end
end
