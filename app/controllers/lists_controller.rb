class ListsController < ApplicationController
  def show
    @lists_sidebar = List.where(user: current_user).order(updated_at: :desc).first(5)
    @lists = List.where(user: current_user)
    @list = List.find(params[:id])
  end

  def index
    @lists_sidebar = List.where(user: current_user).order(updated_at: :desc).first(5)
    @lists = List.where(user: current_user)
    @list = List.new
  end

  def create
    @list = List.new(list_params)
    @list.user = current_user

    respond_to do |format|
      if @list.save!
        format.html { redirect_to list_path(@list) }
        format.json # Follows the classic Rails flow and look for a create.json view
      else
        format.html { render "settings/lists", status: :unprocessable_entity }
        format.json # Follows the classic Rails flow and look for a create.json view
      end
    end
  end

  def edit
    @list = List.find(params[:id])
    @lists_sidebar = List.where(user: current_user).order(updated_at: :desc).first(5)
  end

  def update
    @list = List.find(params[:id])
    if @list.update(list_params)
      redirect_to settings_lists_path
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @list = List.find(params[:id])
    @list.destroy
    redirect_to settings_lists_path
  end

  private

  def list_params
    params.require(:list).permit(:name)
  end
end
