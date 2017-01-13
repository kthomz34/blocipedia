class CollaboratorsController < ApplicationController
  include Pundit
  
  before_action :authenticate_user!
  
  def create
    @wiki = Wiki.find(params[:wiki_id])
    collaborator = @wiki.collaborators.build(collaborator_params)
    
    if collaborator.save
      flash[:notice] = "Collaborator added."
      redirect_to @wiki
    else
      flash[:error] = "There was an error adding the Collaborator."
      redirect_to edit_wiki_path
    end
  end
  
  
  def destroy
    @wiki = Wiki.find(params[:wiki_id])
    collaborator = Collaborator.find(params[:id])
    if collaborator.destroy
      flash[:notice] = "Collaborator removed."
      redirect_to @wiki
    else
      flash[:error] = "Error. Please try again."
      render :show
    end
  end
  
  private
  
  def collaborator_params
    params.require(:collaborator).permit(:user_id)
  end
end
