class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :confirmable, :omniauthable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me
  # attr_accessible :title, :body

  has_many :manuscripts, dependent: :destroy
  has_many :betas, dependent: :destroy

  def self.find_or_create_for_twitter(response)
    data = response['extra']['user_hash']
    if user = User.find_by_twitter_id(response[:id])
      user
    else #Create user with stub password
      user = User.new(
                    :email => "twitter+#{data["id"]}@example.com",
                    :password => Devise.friendly_token[0,20])
      user.twitter_id = response[:id]
      user.twitter_screen_name = response[:screen_name]
      user.twitter_display_name = response[:display_name]
      user.confirm!
    end
  end
end