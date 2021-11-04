defmodule IzaWeb.PageController do
  use IzaWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
