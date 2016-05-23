class FriendshipsController < ApplicationController
	
	def index
		if user_signed_in? 
			@user = current_user
			@friendship = Friendship.new
			@friendships = Friendship.all
		else
			redirect_to new_user_session_url
		end
	end

	def new
	    @user = Friendship.new
	end

	def create
		if user_signed_in? 
			@email = params[:friendship][:email]
			puts @email
			@users = User.all
		    for	user in @users do 
				if user.email == @email
					@friendship = Friendship.new(params[:email])
					@friendship[:user_id] = current_user.id
					@friendship[:friend_id] = user.id
					@friendship.save
					redirect_to friendships_url
				end
			end
		else
			redirect_to new_user_session_url
		end
		# redirect_to root_url
		# redirect_to friendships_url
	  # @friendship = current_user.friendships.build(:friend_id => params[:friend_id])
	  # if @friendship.save
	  #   flash[:notice] = "Added friend."
	  #   redirect_to root_url
	  # else
	  #   flash[:error] = "Unable to add friend."
	  #   redirect_to root_url
	  # end
	end

	def destroy
		if user_signed_in? 
		  @friendship = current_user.friendships.find(params[:id])
		  @friendship.destroy
		  flash[:notice] = "Removed friendship."
		  redirect_to current_user
	  	else
			redirect_to new_user_session_url
		end
	end



end
