module SessionsHelper
  def current_user
    User.find_by(id: session[:user_id])
  end

  def log_in(user)
    session[:user_id] = user.id
  end

  def verify_author
    unless Gossip.find(params[:id]).user_id == current_user.id
      flash[:danger] = "Action impossible : vous n'êtes pas l'auteur de ce potin !"
      redirect_to gossip_path
    end
  end

  private

  def authenticate_user
    unless current_user
      flash[:danger] = "Veuillez vous connecter pour accéder à cette page"
      redirect_to new_session_path
    end
  end
end
