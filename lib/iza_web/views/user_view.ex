defmodule IzaWeb.UserView do
  use IzaWeb, :view

  def render("user.json", %{user: user, address: address}) do
    %{
      status: :ok,
      data: %{
        user: %{name: user.name, email: user.email, document: user.document},
        address: %{street: address.street, city: address.city, state: address.state}
      }
    }
  end

  def render("error.json", %{operation: operation, error: %Ecto.Changeset{} = changeset}) do
    errors = Ecto.Changeset.traverse_errors(changeset, &translate_error/1)
    render("error.json", %{operation: operation, error: errors})
  end

  def render("error.json", %{operation: operation, error: errors}) do
    %{
      status: :error,
      data: %{operation: operation, error: errors}
    }
  end
end
