defmodule IzaWeb.UserController do
  use IzaWeb, :controller

  alias Ecto.Multi
  alias Iza.Users.Address
  alias Iza.Users.User

  def create_user(conn, %{"address" => address} = params) do
    user_params = Map.drop(params, ["address"])

    Multi.new()
    |> Multi.insert(:user, User.changeset(%User{}, user_params))
    |> Multi.insert(:address, fn %{user: user} ->
      address_params = Map.put(address, "user_id", user.id)

      Address.changeset(%Address{}, address_params)
    end)
    |> Iza.Repo.transaction()
    |> case do
      {:ok, results} ->
        conn
        |> put_status(200)
        |> render("user.json", results)

      {:error, failed_operation, error, _} ->
        conn
        |> put_status(200)
        |> render("error.json", %{operation: failed_operation, error: error})
    end
  end
end
