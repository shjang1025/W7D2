class ApplicationController < ActionController::Base
    def current_user
        @current_user ||= User.find_by(session_token: session[:session_token])
    end

    def require_logged_in
        redirect_to new_session_url unless user.logged_in?
    end
    def require_logged_out
        redirect_to users_url if user.logged_in?
    end

    def log_in(user)
        session[:session_token] = user.reset_session_token!
    end
    def logged_in?
        !!current_user
    end
    def log_out
        current_user.reset_session_token!
        session[:session_token] = nil
        @current_user = nil
    end
end
