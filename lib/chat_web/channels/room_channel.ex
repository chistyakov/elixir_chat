defmodule ChatWeb.RoomChannel do
  use ChatWeb, :channel

  alias Chat.Chats

  def join("room:" <> room_id, _payload, socket) do
    socket = assign(socket, :room_id, String.to_integer(room_id))
    send(self(), :after_join)
    {:ok, socket}
  end

  def handle_info(:after_join, socket) do
    Chats.list_messages(socket.assigns.room_id)
    |> Enum.each(fn msg -> push(socket, "shout", %{
        username: msg.username,
        body: msg.body,
      }) end)
    {:noreply, socket} # :noreply
  end

  def handle_in("shout", %{"body" => body}, socket) do
    payload = %{
      body: body,
      username: socket.assigns.username,
      room_id: socket.assigns.room_id
    }
    Chats.create_message(payload)
    broadcast socket, "shout", payload
    {:noreply, socket}
  end

end
