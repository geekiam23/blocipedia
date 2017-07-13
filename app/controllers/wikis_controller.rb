class WikisController < ApplicationController


  def index
    @wikis = Wiki.all
    authorize @wikis
    # @wikis = Wiki.visible_to(current_user)
    #
    # if current_user.premium? || current_user.admin?
    #   @wikis = Wiki.all
    # end
  end

  def show
    @wiki = Wiki.find(params[:id])
  end

  def new
    @user = current_user
    @wiki = Wiki.new
    authorize @wiki
  end

  def create
    @wiki = Wiki.new(wiki_params)
    @wiki.user = current_user
    authorize @wiki

    # @wiki.title = params[:wiki][:title]
    # @wiki.body = params[:wiki][:body]

    if @wiki.private && @wiki.user.standard?
      flash[:notice] = "You need a premium account to make your Wiki private."
      render :new
    else
      if @wiki.save
        flash[:notice] = "Wiki was saved."
        redirect_to @wiki
      else
        flash.now[:alert] = "There was an error saving the wiki. Please try again."
        render :new
      end
    end
  end

  def edit
    @wiki = Wiki.find(params[:id])
    authorize @wiki
  end

  def update
    @wiki = Wiki.find(params[:id])
    authorize @wiki
    @wiki.assign_attributes(wiki_params)

    # @wiki.title = params[:wiki][:title]
    # @wiki.body = params[:wiki][:body]

    if @wiki.private && @wiki.user.standard?
      flash[:alert] = "You need a Premium account to make your Wiki private."
      render :edit
    else
      if @wiki.save
        flash[:notice] = "wiki was updated."
        redirect_to @wiki
      else
        flash.now[:alert] = "There was an error saving the wiki. Please try again."
        render :edit
      end
    end
  end

  def destroy
    @wiki = Wiki.find(params[:id])
    authorize @wiki

    if @wiki.destroy
      flash[:notice] = "\"#{@wiki.title}\" was deleted successfully."
      redirect_to wikis_path
    else
      flash.now[:alert] = "There was an error deleting the wiki."
      render :show
    end
  end

  private

  def wiki_params
    params.require(:wiki).permit(:title, :body, :private)
  end

  def authorize_user
    unless current_user.admin? || current_user.premium?
      flash[:alert] = "You must be an admin to do that."
      redirect_to wikis_path
    end
  end
end
