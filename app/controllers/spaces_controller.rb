class SpacesController < ApplicationController
  before_action :logged_in_user, only: [:index, :new, :create, :edit, :update, :destroy]
  before_action :admin_user,     only: [:new, :create, :edit, :update, :destroy]
  #order is importanta
  before_action :set_space, only: [:edit, :update, :destroy]

 

  # GET /spaces
  def index
    @spaces = current_user.venue.spaces
  end

  # GET /spaces/new
  def new
    @space = current_user.venue.spaces.new
  end

  # GET /spaces/1/edit
  def edit
  end

  # POST /spaces
  def create
    @space = current_user.venue.spaces.build(space_params)
    if @space.save
      flash[:success] = "Add space"
      redirect_to spaces_path
    else
      render :new
    end
  end
  
  # PATCH/PUT /spaces/1
  def update
    if @space.update(space_params)
       flash[:success] = "Space updated"
      redirect_to spaces_path
    else
      render :new
    end
  end

  # DELETE /spaces/1
  # DELETE /spaces/1.json
  def destroy
    @space.destroy
    respond_to do |format|
      format.html { redirect_to spaces_url, notice: 'Space was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

    def set_space
      @space = Space.find(params[:id])
      #Correct space in venue
      redirect_to root_path unless current_user.venue.spaces.include?(@space)

    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def space_params
      params.require(:space).permit(:name)
    end
end
