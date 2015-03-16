class ChirpsController < ApplicationController
  before_action :set_chirp, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]

  respond_to :html

  def index
    @chirps = Chirp.all
    respond_with(@chirps)
  end

  def show
    respond_with(@chirp)
  end

  def new
    @chirp = Chirp.new
    respond_with(@chirp)
  end

  def edit
  end

  def create
    @chirp = Chirp.new(chirp_params)
    if @chirp.save
      redirect_to '/', notice: 'Chirp was successfully created.'
    else
      render :new
    end
    #respond_with(@chirp)
  end

  def update
    @chirp.update(chirp_params)
    if @chirp.save
      redirect_to @chirp, notice: 'Chirp was successfully updated.'
    else
      render :new
    end
    # respond_with(@chirp)
  end

  def destroy
    @chirp.destroy
    #render :index, notice: 'Chirp was successfully deleted.'
    respond_with(@chirp)
  end

  private
    def set_chirp
      @chirp = Chirp.find(params[:id])
    end

    def chirp_params
      params.require(:chirp).permit(:body).merge(user: current_user)
    end
end
