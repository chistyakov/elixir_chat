defmodule Chat.Chats.Message do
  use Ecto.Schema
  import Ecto.Changeset


  schema "messages" do
    field :body, :string
    field :username, :string
    field :room_id, :id

    timestamps()
  end

  @doc false
  def changeset(message, attrs) do
    message
    |> cast(attrs, [:username, :body, :room_id])
    |> validate_required([:username, :body, :room_id])
  end
end
