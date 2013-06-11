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
    data = response["extra"]["raw_info"]
    if user = User.find_by_twitter_id(data["id"])
      user
    else
      user = User.new(:email => "twitter+#{data["id"]}@example.com",
                      :password => Devise.friendly_token[0,20])
      user.twitter_id = data["id"]
      user.twitter_screen_name = data["screen_name"]
      user.twitter_display_name = data["display_name"]
      user.confirm!
      user
    end
  end
end