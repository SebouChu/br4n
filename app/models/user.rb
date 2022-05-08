class User < ApplicationRecord
  include WithAuthentication

  def to_s
    full_name.blank? ? email : full_name
  end

  def full_name
    @full_name ||= "#{first_name} #{last_name}".strip
  end
end
