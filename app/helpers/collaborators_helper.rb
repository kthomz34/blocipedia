module CollaboratorsHelper
  def user_is_authorized_to_remove?(collaborator)
    current_user && (current_user == @wiki.user || current_user.admin?)
  end
end
