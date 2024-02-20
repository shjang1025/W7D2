class User < ApplicationRecord

    def self.find_by_credentials(username, password)
        user = User.find_by(username: username)
        if user.is_password?(password)
            user
        else 
            nil
        end
    end

    def password=(password)
        @password = password
        password_digest = BCrypt::Password.create(password)
    end

    def is_password?(password)
        bc = BCrypt::Password.new(password_digest)
        bc.is_password?(password)
    end

    def reset_session_token!
        session_token = SecureRandom.urlsafe_base64
        self.save!
        self.session_token
    end

    def ensure_session_token
        session_token ||= SecureRandom.urlsafe_base64
    end

end
