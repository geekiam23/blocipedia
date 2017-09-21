class WikisController < ApplicationController
  include ApplicationHelper
  skip_before_action :authenticate_user!, only: [:index, :show]

  def index
    @wikis = policy_scope(Wiki)
  end

  def show
    @wiki = Wiki.find(params[:id])
    @users = Collaborator.all
  end

  def new
    @wiki = Wiki.new
    authorize @wiki

    if @wiki.private && @wiki.user.standard?
			flash[:alert] = "You need a Premium account to make your Wiki private."
			render :index
		end
  end

  def create
		@wiki = Wiki.new(wiki_params)
		@wiki.user = current_user

		if @wiki.private && @wiki.user.standard?
			flash[:alert] = "You need a Premium account to make your Wiki private."
			render :new
		else
			if @wiki.save
				flash[:notice] = "Wiki was saved successfully."
				redirect_to @wiki
			else
				flash[:alert] = "There was an error saving the wiki. Please try again."
				render :new
			end
		end
	end

  def edit
    @wiki = Wiki.find(params[:id])
    @users = User.all
    @collaborator = Collaborator.new
    authorize @wiki
  end

  def update
    @wiki = Wiki.find(params[:id])
    @wiki.title = params[:wiki][:title]
    @wiki.body = params[:wiki][:body]
    authorize @wiki


    if @wiki.update(wiki_params)
      flash[:notice] = "Wiki was updated."
      redirect_to @wiki
    else
      flash.now[:alert] = "There was an error saving the wiki. Please try again."
      render :edit
    end
  end

  def destroy
    @wiki = Wiki.find(params[:id])


    if @wiki.destroy
      flash[:notice] = "\"#{@wiki.title}\" was deleted successfully."
      redirect_to wikis_path
    else
      flash.now[:alert] = "There was an error deleting the wiki."
      render :show
    end
  end

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  private

  def user_not_authorized(exception)
    policy_name = exception.policy.class.to_s.underscore
    flash[:warning] = t "#{policy_name}.#{exception.query}", scope: "pundit", default: :default
    redirect_to(request.referrer || root_path)
  end

  def wiki_params
    params.require(:wiki).permit(:title, :body, :private, :user_id)
  end
end
