class User < ApplicationRecord

    attr_reader :password

    validates :email, presence: true
    validates :password, length: {minimum: 6, allow_nil: true}
    validates :email, uniqueness: true

    after_initialize :ensure_session_token

    def self.find_by_credentials(username, password)
        user = User.find_by(email: username)
        if user.is_password?(password)
            user
        else 
            nil
        end
    end

    def password=(password)
        @password = password
        self.password_digest = BCrypt::Password.create(password)
    end

    def is_password?(password)
        bc = BCrypt::Password.new(password_digest)
        bc.is_password?(password)
    end

    def reset_session_token!
        self.session_token = SecureRandom::urlsafe_base64
        self.save!
        self.session_token
    end

    def ensure_session_token
        self.session_token ||= SecureRandom::urlsafe_base64
    end
end
