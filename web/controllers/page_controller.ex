defmodule MyApp.PageController do
  use MyApp.Web, :controller

  def index(conn, _params) do
    conn
    |> put_status(:forbidden)
    |> render("index.html")
  end
end
