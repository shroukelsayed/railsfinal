class InvitationsController < ApplicationController
  before_action :set_invitation, only: [:show, :edit, :update, :destroy]

  # GET /orders
  # GET /orders.json
  def index
    @user = current_user
    @invitations = Invitation.all
    @invitation = Invitation.new
 
  end

  # GET /orders/1
  # GET /orders/1.json
  def show
  end

  # GET /orders/new
  def new
    @invitation = Invitation.new
  end

  # GET /orders/1/edit
  def edit
  end

  # POST /orders
  # POST /orders.json
  def create
    @email = params[:invitation][:email]
    @order =params[:invitation][:order_id]
    puts @email
    @users = User.all
      for user in @users do 
        if user.email == @email
          @invitation = Invitation.new(params[:email])
          @invitation[:order_id] = @order
          @invitation[:friend_id] = user.id
          @invitation[:accept]=0
          respond_to do |format|
          if (@invitation.save)
            @noti = Notification.new({"order_id"=>@invitation[:order_id]})
            if @noti.save
            format.html { redirect_to invitations_url, notice: 'Order member was successfully created.' }
            format.json { head :no_content}
          end
        end
        end
    
      end 
    end

end

  def update
    # respond_to do |format|
      if @invitation.update(invitation_params)
        redirect_to invitations_url
      else
        format.html { render :edit }
        format.json { render json: @invitation.errors, status: :unprocessable_entity }
      # end
    end
  end

  def destroy
    @invitation= current_user.friendships.find(params[:id])
    @friendship.destroy
    flash[:notice] = "Removed friendship."
    redirect_to current_user
  
     @invitation= current_user.friendships.find(params[:id])
     @invitation.destroy
      flash[:notice] = "Removed friendship."
      redirect_to invitations_url
    
  end

 

    def set_invitation
      @invitatio = Invitation.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def invitation_params
      params.require(:invitation).permit(:order_id, :friend_id, :accept)
    end
end
