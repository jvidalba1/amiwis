class GamesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_group, only: [:new, :create]
  before_action :set_game, only: [:show]
  load_and_authorize_resource

  def show
    @active_inscriptions = Inscription.active(@game.id)
    @bench_inscriptions = Inscription.bench(@game.id)
  end

  def new
    @game = @group.games.new
  end

  def create
    @game = @group.games.new(game_params)
    @game.current_users = 0 # se puede reemplazar poniendo por default 0 en la bd

    @game.game_date = @game.join_date_time(game_params[:game_date_date], game_params[:game_date_time])

    respond_to do |format|
      if @game.save
        @game.active!
        format.html { redirect_to @group, notice: 'Partido creado exitosamente.' }
        format.json { render :show, status: :created, location: @game }
      else
        format.html { render :new }
        format.json { render json: @game.errors, status: :unprocessable_entity }
      end
    end
  end

  private

    def set_group
      @group = Group.find(params[:group_id])
    end

    def set_game
      @game = Game.find(params[:id])
    end

    def game_params
      params.require(:game).permit(:game_date, :place, :limit_users, :game_date_date, :game_date_time)
    end
end
