defmodule Iza.Users.User do
  use Ecto.Schema

  import Ecto.Changeset

  alias Iza.Users.Address

  schema "users" do
    field(:name, :string)
    field(:email, :string)
    field(:document, :string)

    has_many(:addresses, Address)

    timestamps()
  end

  @required_fields [:name, :email, :document]
  def changeset(%__MODULE__{} = struct, params \\ %{}) do
    struct
    |> cast(params, @required_fields)
    |> validate_required(@required_fields)
  end
end
