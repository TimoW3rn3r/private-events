class InvitationsController < ApplicationController
  def new
    @invitation = Invitation.new
  end

  def create
    event_id = params[:invitation][:event_id]
    @invitation = Invitation.new(invite_params)

    if @invitation.save
      redirect_to event_path(event_id)
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def invite_params
    params.require(:invitation).permit(:event_id, :user_id)
  end
end
