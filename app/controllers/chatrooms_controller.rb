class ChatroomsController < ApplicationController
  def index
    @chatrooms = Chatroom.all
  end

  def show
  end
end
