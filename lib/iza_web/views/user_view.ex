defmodule IzaWeb.UserView do
  use IzaWeb, :view

  def render("user.json", %{user: user, address: address}) do
    %{
      status: :ok,
      data: %{user: user, address: address}
    }
  end

  def render("error.json", %{operation: operation, error: %Ecto.Changeset{errors: errors}}) do
    render("error.json", %{operation: operation, error: errors})
  end

  def render("error.json", %{operation: operation, error: errors}) do
    %{
      status: :error,
      data: %{operation: operation, error: errors}
    }
  end
end
