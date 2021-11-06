defmodule IzaWeb.UserView do
  use IzaWeb, :view

  def render("success.json", %{results: results}) when is_list(results) do
    Enum.reduce(results, [], fn {status, result}, acc ->
      [build_response(status, result)] ++ acc
    end)
  end

  def render("success.json", %{results: results}), do: build_response(:ok, results)

  def render("error.json", results), do: build_response(:error, results)

  def build_response(:ok, %{user: user, address: address}) do
    %{
      status: :ok,
      data: %{
        user: %{name: user.name, email: user.email, document: user.document},
        address: %{street: address.street, city: address.city, state: address.state}
      }
    }
  end

  def build_response(:error, %{operation: operation, error: %Ecto.Changeset{} = changeset}) do
    errors = Ecto.Changeset.traverse_errors(changeset, &translate_error/1)
    build_response(:error, %{operation: operation, error: errors})
  end

  def build_response(:error, %{operation: operation, error: errors}) do
    %{
      status: :error,
      data: %{entity: operation, error: errors}
    }
  end
end
