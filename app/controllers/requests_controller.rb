class RequestsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_group, only: [:create]
  before_action :set_user, only: [:create]
  before_action :set_request, only: [:accept, :deny]
  load_and_authorize_resource

  def index
  end

  def create
    @request = @group.requests.new(user: @user)
    @request.request_date = Time.now

    respond_to do |format|
      if @request.save
        @request.pending!
        format.html { redirect_to groups_path, notice: 'Solicitud enviada al admin del grupo.' }
        format.json { render :show, status: :created, location: @request }
      else
        format.html { render :new }
        format.json { render json: @request.errors, status: :unprocessable_entity }
      end
    end
  end

  def accept
    @request.accepted!
    @request.reply_at = Time.now
    @request.group.users << @request.user

    respond_to do |format|
      if @request.save
        format.html { redirect_to @request.group, notice: 'Solicitud aceptada.' }
        format.json { render :show, status: :ok, location: @request.group }
      else
        format.html { redirect_to @request.group }
        format.json { render json: @request.errors, status: :unprocessable_entity }
      end
    end
  end

  def deny
    @request.denied!
    @request.reply_at = Time.now

    respond_to do |format|
      if @request.save
        format.html { redirect_to @request.group, notice: 'Solicitud rechazada.' }
        format.json { render :show, status: :ok, location: @request.group }
      else
        format.html { redirect_to @request.group }
        format.json { render json: @request.errors, status: :unprocessable_entity }
      end
    end
  end

  private

    def set_request
      @request = Request.find(request_params[:id])
    end

    def set_group
      @group = Group.find(request_params[:group_id])
    end

    def set_user
      @user = User.find(request_params[:user_id])
    end

    def request_params
      params.permit(:id, :group_id, :user_id)
    end
end
