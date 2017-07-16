class CollaboratorsController < ApplicationController
  before_action :get_wiki

    def index
      @users = User.all
    end

    def create
      @collaborator = @wiki.collaborators.new(user_id: params[:user_id])

      if @collaborator.save
        flash[:notice] = "Collaborator added successfully. You can remove them at anytime."
      else
        flash[:alert] = 'An error has occured.'
      end

      redirect_to @wiki
    end

    def destroy
      @collaborator = Collaborator.find(params[:id])

      if @collaborator.destroy
        flash[:notice] = 'Collaborator has been removed.'
      else
        flash[:alert] = 'An error has occured.'
      end

      redirect_to @wiki
    end

  private

    def get_wiki
      @wiki = Wiki.find(params[:wiki_id])
    end
end
