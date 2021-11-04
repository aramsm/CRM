defmodule Iza.Repo do
  use Ecto.Repo,
    otp_app: :iza,
    adapter: Ecto.Adapters.Postgres
end
