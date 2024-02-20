class SessionsController < ApplicationController
    def new
        render :sign_in
    end
    #API section
    def create
        email = params[:session][:email]
        password = params[:session][:password]
        user = User.find_by_credentials(email, password)
        if user
            log_in(user)
            redirect_to bands_url
        else 
            redirect_to new_session_url
        end
    end

    def destroy
        log_out
        redirect_to bands_url
    end
    #helper section
    private
    def session_params
        params.require(:session).permit(:email, :password)
    end
end
