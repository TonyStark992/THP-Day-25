class GossipsController < ApplicationController
  before_action :authenticate_user, only: [:new, :create, :show]
  before_action only: [:edit, :update, :destroy] do |controller|
    controller.verify_author
  end

  def index
    @gossips = Gossip.all
  end

  def show
    @gossip = Gossip.find(params[:id])
  end

  def new

  end

  def create
  @gossip = Gossip.new(title: params[:title], content: params[:content], user_id: current_user.id)

    if @gossip.save
      flash[:success] = "Potin bien créé !"
      redirect_to gossips_path
    else
      render :new
    end
  end

  def edit
    @gossip = Gossip.find(params[:id])
  end

  def update
    @gossip = Gossip.find(params[:id])
    if @gossip.update(gossip_params)
      flash[:success] = "Potin édité !"
      redirect_to @gossip
    else
      render :edit
    end
  end

  def destroy
    @gossip = Gossip.find(params[:id])
    @gossip.destroy
    flash[:success] = "Potin supprimé !"
    redirect_to gossips_path
  end

  private

  def gossip_params
    params.require(:gossip).permit(:title, :content)
  end

end
