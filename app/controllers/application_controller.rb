class ApplicationController < ActionController::Base
  protect_from_forgery

  rescue_from CanCan::AccessDenied do |exception|
    respond_to do |format|
      format.json { head :forbidden, content_type: 'text/html' }
      format.html { redirect_to main_app.root_url, alert: exception.message }
      format.js   { head :forbidden, content_type: 'text/html' }
    end
  end

  layout 'sandstone'

  def current_ability
    @current_ability ||= Ability.new(current_user, params)
  end

  def after_sign_up_path_for(resource)
    edit_user_registration_path
  end
end
