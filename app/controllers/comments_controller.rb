class CommentsController < ApplicationController
  before_action :authenticate_user, only: [:new, :create]

  def new

  end

  def create
    @comment = Comment.new(content: params[:content], user_id: current_user.id, gossip_id: params[:gossip_id])
    if @comment.save
      redirect_to gossip_path(params[:gossip_id])
    else
      render 'new'
    end
  end

  def edit
    @gossip = Gossip.find(params[:gossip_id])
    @comment = Comment.find(params[:id])
  end

  def update
    @gossip = Gossip.find(params[:gossip_id])
    @comment = Comment.find(params[:id])
    if @comment.update(comment_params)
      redirect_to @gossip
    else
      render :edit
    end
  end

  def destroy
    @gossip = Gossip.find(params[:gossip_id])
    @comment = Comment.find(params[:id])
    @comment.destroy
    redirect_to @gossip
  end

  private

  def comment_params
    params.require(:comment).permit(:content)
  end
end
