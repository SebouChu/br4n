module User::WithAuthentication
  extend ActiveSupport::Concern

  included do
    # Include default devise modules. Others available are:
    # :registerable, :confirmable, :lockable, :timeoutable and :trackable
    devise  :database_authenticatable, :recoverable, :rememberable, :validatable,
            :omniauthable, omniauth_providers: %i(doorkeeper openid_connect)

    enum role: { visitor: 0, admin: 10 }

    validates :role, presence: true

    def update_doorkeeper_credentials(auth)
      update(
        doorkeeper_access_token: auth.credentials.token,
        doorkeeper_refresh_token: auth.credentials.refresh_token
      )
    end
  end

  class_methods do
    def from_omniauth(auth)
      user = where(provider: auth.provider, uid: auth.uid).first_or_initialize(password: Devise.friendly_token[0, 20])
      user.assign_attributes(
        email: auth.info.email,
        first_name: (auth.provider == "doorkeeper" ? auth.info.first_name : auth.extra.raw_info.first_name),
        last_name: (auth.provider == "doorkeeper" ? auth.info.last_name : auth.extra.raw_info.last_name),
        role: (auth.provider == "doorkeeper" ? auth.info.role : auth.extra.raw_info.role)
      )
      user.save
      user
    end
  end
end