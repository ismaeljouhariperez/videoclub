class ListsController < ApplicationController
  def show
  end

  def index
    @lists = List.where(user: current_user)
  end

  def destroy
    @list = List.find(params[:id])
    @list.destroy
    redirect_to settings_lists_path
  end
end
