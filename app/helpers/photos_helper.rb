module PhotosHelper
  def logged_in_user
    unless signed_in?
      store_location
      flash[:danger] = 'Please log in.'
      redirect_to user_session_path
    end
  end

  def correct_user
    @photo = Photo.find(params[:id])
    @user = @photo.user_id
    redirect_to(root_url) unless @user == current_user.id
  end

  def redirect_back_or(default)
    redirect_to(session[:forwarding_url] || default)
    session.delete(:forwarding_url)
  end

  def store_location
    session[:forwarding_url] = request.url if request.get?
  end

  def moderator_user
    redirect_to(root_url) unless current_user.moderator?
  end
end
