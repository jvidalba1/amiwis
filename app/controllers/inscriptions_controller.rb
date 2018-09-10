class InscriptionsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_game, only: [:create]
  before_action :set_user, only: [:create]
  # before_action :set_inscription, only: [:enroll]
  load_and_authorize_resource

  def create
    @inscription = @game.inscriptions.new(user: @user)
    @inscription.incription_date = Time.now

    @inscription.validate_game_quota!

    respond_to do |format|
      if @inscription.save
        message = @inscription.bench? ? "Has quedado en espera." : "Te has inscrito al partido exitosamente."
        format.html { redirect_to @inscription.game, notice: message }
        format.json { render :show, status: :created, location: @inscription }
      else
        format.html { render :new }
        format.json { render json: @inscription.errors, status: :unprocessable_entity }
      end
    end
  end

  def inactive
    @inscription = Inscription.find(params[:id])

    @inscription.inactive_inscription!

    respond_to do |format|
      if @inscription.save
        format.html { redirect_to @inscription.game.group, notice: 'Te has borrado del partido exitosamente.' }
        format.json { render :show, status: :ok, location: @inscription.game.group }
      else
        format.html { render :new }
        format.json { render json: @inscription.errors, status: :unprocessable_entity }
      end
    end
  end

  private

    def set_game
      @game = Game.find(inscription_params[:game_id])
    end

    def set_user
      @user = User.find(inscription_params[:user_id])
    end

    def inscription_params
      params.permit(:id, :game_id, :user_id)
    end
end
