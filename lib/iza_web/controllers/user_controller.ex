defmodule IzaWeb.UserController do
  use IzaWeb, :controller

  alias Iza.Users

  def create_user(conn, params) do
    Users.create_user_with_address(params)
    |> case do
      {:ok, results} ->
        conn
        |> put_status(200)
        |> render("success.json", %{results: results})

      {:error, failed_operation, error, _} ->
        conn
        |> put_status(200)
        |> render("error.json", %{operation: failed_operation, error: error})
    end
  end
end
