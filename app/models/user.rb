class User < ApplicationRecord
  devise :omniauthable, :omniauth_providers => [:facebook]
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :requests
  has_many :inscriptions

  has_and_belongs_to_many :games
  has_and_belongs_to_many :groups

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.email = auth.info.email
      user.password = Devise.friendly_token[0,20]
      user.name = auth.info.name   # assuming the user model has a name
      user.avatar = auth.info.image # assuming the user model has an image
      # If you are using confirmable and the provider(s) you use validate emails,
      # uncomment the line below to skip the confirmation emails.
      # user.skip_confirmation!
    end
  end

  def self.new_with_session(params, session)
    super.tap do |user|
      if data = session["devise.facebook_data"] && session["devise.facebook_data"]["extra"]["raw_info"]
        user.email = data["email"] if user.email.blank?
      end
    end
  end


  # def self.create_from_omniauth(params)
  #   user = find_or_create_by(email: params.info.email, uid: params.uid)
  #   user.update({
  #     token: params.credentials.token,
  #     name: params.info.name,
  #     avatar: params.info.image
  #   })
  #   user
  # end

  def member?(group)
    self.groups.include?(group)
  end

  def enrolled(game)
    self.inscriptions.find_by(game_id: game.id, status: [:active, :bench])
  end

  # def inscription(game)
  #   self.inscriptions.find_by(game_id: game.id)
  # end

end
