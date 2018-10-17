defmodule Chat.ChatsTest do
  use Chat.DataCase

  alias Chat.Chats

  describe "rooms" do
    alias Chat.Chats.Room

    @valid_attrs %{name: "some name"}
    @invalid_attrs %{name: nil}

    def room_fixture(attrs \\ %{}) do
      {:ok, room} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Chats.create_room()

      room
    end

    test "list_rooms/0 returns all rooms" do
      room = room_fixture()
      assert Chats.list_rooms() == [room]
    end

    test "get_room!/1 returns the room with given id" do
      room = room_fixture()
      assert Chats.get_room!(room.id) == room
    end

    test "create_room/1 with valid data creates a room" do
      assert {:ok, %Room{} = room} = Chats.create_room(@valid_attrs)
      assert room.name == "some name"
    end

    test "create_room/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Chats.create_room(@invalid_attrs)
    end
  end

  describe "messages" do
    alias Chat.Chats.Message

    @valid_attrs %{body: "some body", username: "some username"}
    @invalid_attrs %{body: nil, username: nil}

    def message_fixture(attrs \\ %{}) do
      {:ok, room} = Chats.create_room(%{name: "foo"})
      {:ok, message} =
        Map.put(attrs, :room_id, room.id)
        |> Enum.into(@valid_attrs)
        |> Chats.create_message()

      message
    end

    test "list_messages/1 returns all messages of the room" do
      message = message_fixture()
      assert Chats.list_messages(message.room_id) == [message]
    end

    test "create_message/1 with valid data creates a message" do
      message = message_fixture()
      assert message.body == "some body"
      assert message.username == "some username"
    end

    test "create_message/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Chats.create_message(@invalid_attrs)
    end
  end
end
