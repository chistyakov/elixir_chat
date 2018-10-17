defmodule ChatWeb.RoomController do
  use ChatWeb, :controller

  alias Chat.Chats

  def show(conn, %{"id" => id}) do
      %_{:name => name} = Chats.get_room!(id)
      render conn, :show, id: id, name: name
  end

  def new_input(conn, _params) do
      render conn, :new_input
  end

  def create(conn, %{"payload" => %{"name" => name}}) do
      case Chats.create_room(%{name: name}) do
          {:ok, %_{:id => id}} ->
            redirect conn, to: "/room/#{id}"
          {:error, _changeset} ->
            render conn, :new_input
      end
  end
end