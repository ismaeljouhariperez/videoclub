class ChatroomsController < ApplicationController
  def index
    @chatrooms = Chatroom.all
    @chatroom = Chatroom.new
  end

  def show
    @chatroom = Chatroom.find(params[:id])
    @message = Message.new
  end

  def create
    @chatroom = Chatroom.new(chatroom_params)
    @chatroom.user = current_user
    if @chatroom.save
      redirect_to chatrooms_path
    else
      @chatrooms = Chatroom.all
      render :index, status: :unprocessable_entity
    end
  end

  def destroy
    @chatroom = Chatroom.find(params[:id])
    @chatroom.destroy
    redirect_to chatrooms_path
  end

  private

  def chatroom_params
    params.require(:chatroom).permit(:name)
  end
end
