class JewelsController < ApplicationController

  #->Prelang (scaffolding:rails/scope_to_user)
  before_filter :require_user_signed_in, only: [:new, :edit, :create, :update, :destroy]

  before_action :set_jewel, only: [:show, :edit, :update, :destroy, :vote]

  # GET /jewels
  # GET /jewels.json
  def index
    @jewels = Jewel.all
  end

  # GET /jewels/1
  # GET /jewels/1.json
  def show
  end

  # GET /jewels/new
  def new
    @jewel = Jewel.new
  end

  # GET /jewels/1/edit
  def edit
  end

  # POST /jewels
  # POST /jewels.json
  def create
    @jewel = Jewel.new(jewel_params)
    @jewel.user = current_user

    respond_to do |format|
      if @jewel.save
        format.html { redirect_to @jewel, notice: 'Jewel was successfully created.' }
        format.json { render :show, status: :created, location: @jewel }
      else
        format.html { render :new }
        format.json { render json: @jewel.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /jewels/1
  # PATCH/PUT /jewels/1.json
  def update
    respond_to do |format|
      if @jewel.update(jewel_params)
        format.html { redirect_to @jewel, notice: 'Jewel was successfully updated.' }
        format.json { render :show, status: :ok, location: @jewel }
      else
        format.html { render :edit }
        format.json { render json: @jewel.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /jewels/1
  # DELETE /jewels/1.json
  def destroy
    @jewel.destroy
    respond_to do |format|
      format.html { redirect_to jewels_url, notice: 'Jewel was successfully destroyed.' }
      format.json { head :no_content }
    end
  end


  #->Prelang (voting/acts_as_votable)
  def vote

    direction = params[:direction]

    # Make sure we've specified a direction
    raise "No direction parameter specified to #vote action." unless direction

    # Make sure the direction is valid
    unless ["like", "bad"].member? direction
      raise "Direction '#{direction}' is not a valid direction for vote method."
    end

    @jewel.vote_by voter: current_user, vote: direction

    redirect_to action: :index
  end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_jewel
      @jewel = Jewel.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def jewel_params
      params.require(:jewel).permit(:user_id, :color, :price, :weight, :jewel_name, :jewel_description)
    end
end
