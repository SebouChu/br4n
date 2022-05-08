module User::WithAuthentication
  extend ActiveSupport::Concern

  included do
    # Include default devise modules. Others available are:
    # :registerable, :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
    devise :database_authenticatable, :recoverable, :rememberable, :validatable

    enum role: { visitor: 0, admin: 10 }
  end
end