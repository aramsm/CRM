defmodule Iza.Users.Address do
  use Ecto.Schema

  import Ecto.Changeset

  alias Iza.Users.User

  schema "addresses" do
    field(:street, :string)
    field(:city, :string)
    field(:state, :string)

    belongs_to(:user, User)

    timestamps()
  end

  @required_fields [:street, :city, :state, :user_id]
  def changeset(%__MODULE__{} = struct, params \\ %{}) do
    struct
    |> cast(params, @required_fields)
    |> assoc_constraint(:user)
    |> validate_required(@required_fields)
  end
end
