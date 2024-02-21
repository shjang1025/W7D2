class UsersController < ApplicationController
    #User Interface section
    def new
        render :new
    end
    def show
        @user = User.find_by(id: params[:id])
        render :show
    end
    #API section
    def create
        user = User.new(user_params)
        if user.save!
            log_in(user)
            redirect_to user_url(user.id)
        else
            render :new
        end
    end



    #helpers
    private
    def user_params
        params.require(:user).permit(:email, :password)
    end

end
