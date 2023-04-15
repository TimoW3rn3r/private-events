class InvitationsController < ApplicationController
  def new
    @invitation = Invitation.new
  end

  def create
    user_id = current_user.id
    event_id = params[:invitation][:event][:id]
    @invitation = Invitation.new(user_id: user_id, event_id: event_id)

    if @invitation.save
      redirect_to event_path(event_id)
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def invite_params
    params.require(:invitation).permit(:event)
  end
end
