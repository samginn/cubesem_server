defmodule MyApp.SessionController do
  use MyApp.Web, :controller

  plug :scrub_params, "session" when action in [:create]

  def create(conn, %{"session" => params}) do
    session_params = Poison.decode!(params)
    case MyApp.Session.authenticate(session_params) do
      {:ok, user} ->
        {:ok, jwt, _full_claims} = user |> Guardian.encode_and_sign(:token)

        conn
        |> put_status(:created)
        |> render("show.json", jwt: jwt, user: user)

      :error ->
        conn
        |> put_status(:unprocessable_entity)
        |> render("error.json")
    end
  end

  def delete(conn, _params) do
    {:ok, claims} = Guardian.Plug.claims(conn)

    conn
    |> Guardian.Plug.current_token
    |> Guardian.revoke!(claims)

    conn
    |> render("delete.json")
  end

  def unauthenticated(conn, _params) do
    conn
    |> put_status(:forbidden)
    |> render(MyApp.SessionView, "forbidden.json", error: "Not authenticated")
  end
end
