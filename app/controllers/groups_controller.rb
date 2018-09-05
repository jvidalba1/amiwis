class GroupsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_group, only: [:show, :edit, :update, :destroy, :request_entry]
  load_and_authorize_resource

  def index
    @groups = Group.all
  end

  def show
    @pending_requets = @group.requests.pending(@group.id)
    @replied_requests = Request.replied(@group.id)
    @games = @group.games
  end

  def new
    @group = Group.new
  end

  def create
    @group = Group.new(group_params)
    @group.assign_admin(current_user)
    @group.add_user(current_user)

    respond_to do |format|
      if @group.save
        format.html { redirect_to @group, notice: 'Grupo creado exitosamente.' }
        format.json { render :show, status: :created, location: @group }
      else
        format.html { render :new }
        format.json { render json: @group.errors, status: :unprocessable_entity }
      end
    end
  end

  def edit
  end

  def update
    respond_to do |format|
      if @group.update(group_params)
        format.html { redirect_to @group, notice: 'Group was successfully updated.' }
        format.json { render :show, status: :ok, location: @group }
      else
        format.html { render :edit }
        format.json { render json: @group.errors, status: :unprocessable_entity }
      end
    end
  end

  private

    def set_group
      @group = Group.find(params[:id])
    end

    def group_params
      params.require(:group).permit(:name)
    end
end
