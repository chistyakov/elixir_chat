defmodule ChatWeb.RoomChannelTest do
  use ChatWeb.ChannelCase

  alias ChatWeb.RoomChannel

  setup do
    {:ok, _, socket} =
      socket("user_id", %{:username => "alice"})
      |> subscribe_and_join(RoomChannel, "room:1")

    {:ok, socket: socket}
  end

  test "broadcasts are pushed to the client", %{socket: socket} do
    broadcast_from! socket, "broadcast", %{"username" => "foo", "body" => "bar"}
    assert_push "broadcast", %{"username" => "foo", "body" => "bar"}
  end
end
