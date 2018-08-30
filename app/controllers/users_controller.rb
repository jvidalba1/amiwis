class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user, only: [:show, :edit, :update, :destroy]

  def show
    @groups = @user.groups
  end

  def edit
  end

  def update
  end

  def destroy
  end

  private

    def set_user
      @user = User.find(params[:id])
    end

    def group_params
      params.require(:user).permit(:name, :email)
    end

end
