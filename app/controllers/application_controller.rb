class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  before_action :set_list_sidebar


  def set_list_sidebar
    @lists_sidebar = List.where(user: current_user).order(updated_at: :desc).first(5)
    @list = List.new
  end
end
