defmodule Iza.Users do
  alias Ecto.Multi

  alias Iza.Users.Address
  alias Iza.Users.User

  def create_user_with_address(%{"file" => %Plug.Upload{content_type: "text/csv", path: path}}) do
    results =
      path
      |> File.stream!()
      |> Stream.map(&String.trim(&1, "\n"))
      |> Stream.map(&String.split(&1, ","))
      |> Enum.map(fn element ->
        Task.async(fn ->
          element
          |> parse_to_map()
          |> create_user_with_address()
        end)
      end)
      |> Task.await_many()

    {:ok, results}
  end

  def create_user_with_address(%{"address" => address} = params) do
    user_params = Map.drop(params, ["address"])

    Multi.new()
    |> Multi.insert(:user, User.changeset(%User{}, user_params))
    |> Multi.insert(:address, fn %{user: user} ->
      address_params = Map.put(address, "user_id", user.id)

      Address.changeset(%Address{}, address_params)
    end)
    |> Iza.Repo.transaction()
  end

  def parse_to_map(row) do
    %{
      "name" => Enum.at(row, 0),
      "email" => Enum.at(row, 1),
      "document" => Enum.at(row, 2),
      "address" => %{
        "street" => Enum.at(row, 3),
        "city" => Enum.at(row, 4),
        "state" => Enum.at(row, 5)
      }
    }
  end
end
