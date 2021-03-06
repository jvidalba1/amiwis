class Auth::CallbacksController < ApplicationController
  def facebook

    @user = User.from_omniauth(request.env["omniauth.auth"])

    if @user.persisted?

      if @user.level.nil? || @user.position.nil? || @user.name.nil?
        sign_in @user
        redirect_to edit_user_registration_path
      else
        sign_in_and_redirect @user
      end
      flash[:notice] = "Has iniciado sesión exitosamente."
      # set_flash_message!(:notice, :success, kind: "Facebook") if is_navigational_format?
    else
      session["devise.facebook_data"] = request.env["omniauth.auth"]
      flash["alert"] = @user.errors.messages.first.flatten.join(" ").capitalize
      redirect_to new_user_registration_url
    end
  end

  def failure
    redirect_to root_path
  end

  # def facebook
  #   user = User.create_from_omniauth(omniauth_params)
  #   sign_in_and_redirect user, event: :authentication if user.persisted?
  # end

  # def failure
  #   redirect_to :root
  # end

  private

    def omniauth_params
      raise "adsf"
      request.env["omniauth.auth"]
    end

  protected

    def set_flash_message!(key, kind, options = {})
      if is_flashing_format?
        set_flash_message(key, kind, options)
      end
    end
end
