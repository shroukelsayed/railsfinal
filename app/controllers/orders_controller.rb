class OrdersController < ApplicationController
  before_action :set_order, only: [:show, :edit, :update, :destroy]

  # GET /orders
  # GET /orders.json
  def index
    @orders = Order.all
    puts @orders
    @invited = []
    @joined = []
    @orders.each do |order| 
      @order_id = order.id
      puts @order_id 

       @invited << Invitation.where("order_id = ?", @order_id).where("invite =1").count
       @joined << Invitation.where("order_id = ?", @order_id).where("accept =1").count
       puts @invited
       puts @joined
    end
  end


  # GET /orders/1
  # GET /orders/1.json
  def show
  end

  # GET /orders/new
  def new
    @order = Order.new
  end

  # GET /orders/1/edit
  def edit
  end

  # POST /orders
  # POST /orders.json
  def create
    @order = Order.new(order_params)
    @order[:status]="waiting"
    @type=params[:order][:order_type]

      if @order.save
        redirect_to invitations_url
      
  end
  end

  # PATCH/PUT /orders/1
  # PATCH/PUT /orders/1.json
  def update
    # respond_to do |format|
      if @order.update(order_params)
        # format.html { redirect_to @order, notice: 'Order was successfully updated.' }
        # format.json { render :show, status: :ok, location: @order }
        redirect_to orders_url
      else
        format.html { render :edit }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      # end
    end
  end

  # DELETE /orders/1
  # DELETE /orders/1.json
  def destroy
    if @order.destroy
    # respond_to do |format|
      # format.html { redirect_to orders_url, notice: 'Order was successfully destroyed.' }
      # format.json { head :no_content }
      redirect_to orders_url
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_order
      @order = Order.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def order_params
       params.require(:order).permit(:order_type, :restaurant, :user_id ,:status)
    end
end
