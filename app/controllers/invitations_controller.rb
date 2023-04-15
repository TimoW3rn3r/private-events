class InvitationsController < ApplicationController
  def new
    @invitation = Invitation.new
  end

  def create
    @invitation = Invitation.new(
      user_id: current_user.id,
      event_id: params[:invitation][:event_id]
    )

    if @invitation.save
      redirect_to events_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def invite_params
    params.require(:invitation).permit(:user_id, :event_id)
  end
end
