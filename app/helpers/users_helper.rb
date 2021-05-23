module UsersHelper
  def is_admin?
    return true if user_signed_in? && current_user.is_admin == true
    
    false
  end
end
