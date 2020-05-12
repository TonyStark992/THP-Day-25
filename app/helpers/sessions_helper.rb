module SessionsHelper

  def current_user
    if session[:user_id]
      # même chose que Day 24 (avant cookies)
      current_user = User.find_by(id: session[:user_id])

    # nous allons vérifier s'il y a bien un cookie contenant l'id de notre utilisateur
    elsif cookies[:user_id]

      # nous allons trouver l'utilisateur en DB à partir du cookie qui stocke le user_id
      user = User.find_by(id: cookies[:user_id])

      # nous allons prendre le remember_token stocké en cookie, le hasher, puis le comparer avec notre remember_digest stocké en base
      if user && BCrypt::Password.new(user.remember_digest).is_password?(cookies[:remember_token])
        log_in(user)
        current_user = user
      end
    end
  end

  def log_in(user)
    session[:user_id] = user.id
  end

  def log_out(user)
    session.delete(:user_id)
    forget(user)
  end

  def remember(user)
    # ici je vais créer un remember_token qui est une suite aléatoire de caractères
    remember_token = SecureRandom.urlsafe_base64

    # j'ai mon token, je vais stocker son digest en base de données : 
    user.remember(remember_token)

    #  maintenant, je vais créer les cookies : un cookie qui va conserver l'user_id, et un autre qui va enregistrer le remember_token
    cookies.permanent[:user_id] = user.id
    cookies.permanent[:remember_token] = remember_token
  end

  def forget(user)
    user.update(remember_digest: nil)
    cookies.delete(:user_id)
    cookies.delete(:remember_token)
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
