class User < ApplicationRecord
  # Include default devise modules. Others available are:
  #   :confirmable, :lockable, :recoverable, :registerable,
  #   :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :rememberable, :validatable
  has_many :cards
  has_many :tags

  def generate_jwt
    JWT.encode(
      { sub: id, exp: 60.days.from_now.to_i },
      Rails.application.secrets.secret_key_base
    )
  end
end
