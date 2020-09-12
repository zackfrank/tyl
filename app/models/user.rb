# == Schema Information
#
# Table name: users
#
#  id                     :bigint           not null, primary key
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  first_name             :string           default(""), not null
#  last_name              :string           default(""), not null
#  remember_created_at    :datetime
#  reset_password_sent_at :datetime
#  reset_password_token   :string
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#
# Indexes
#
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#
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
