defmodule MyApp.UserController do
  use MyApp.Web, :controller

  plug Guardian.Plug.EnsureAuthenticated, handler: MyApp.SessionController

  alias MyApp.{Repo, User}

  def current_user(conn, _) do
    user = Guardian.Plug.current_resource(conn)

    conn
    |> put_status(:ok)
    |> render("show.json", user: user)
  end

  def edit(conn, params) do
    user = Guardian.Plug.current_resource(conn)
    test_password = params["password"]

    if params["new_password"] do
      params = Map.put(params, "password", params["new_password"])
    end

    changeset = User.changeset(user, params)

    if !Comeonin.Bcrypt.checkpw(test_password, user.hashed_password) do
      changeset = Ecto.Changeset.add_error(changeset, :password, "Incorrect password")
    end

    case Repo.update(changeset) do
      {:ok, user} ->
        conn
        |> put_status(:ok)
        |> render("show.json", user: user)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render("error.json", changeset: changeset)
    end
  end
end
