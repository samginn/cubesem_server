defmodule MyApp.RegistrationController do
  use MyApp.Web, :controller

  alias MyApp.{Repo, User}

  plug :scrub_params, "user" when action in [:create]

  def create(conn, %{"user" => params}) do
    user_params = Poison.decode!(params)
    changeset = User.changeset(%User{}, user_params)

    case Repo.insert(changeset) do
      {:ok, user} ->
        {:ok, jwt, _full_claims} = user |> Guardian.encode_and_sign(:token)

        conn
        |> put_status(:created)
        |> render(MyApp.SessionView, "show.json", jwt: jwt, user: user)

      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render("error.json", changeset: changeset)
    end
  end
end
