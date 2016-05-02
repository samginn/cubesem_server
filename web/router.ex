defmodule MyApp.Router do
  use MyApp.Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
    plug Guardian.Plug.VerifyHeader
    plug Guardian.Plug.LoadResource
  end

  scope "/api", MyApp do
    pipe_through :api

    scope "/v1" do
      post "/sign_up", RegistrationController, :create

      post "/session", SessionController, :create
      delete "/session", SessionController, :delete

      get "/user/current_user", UserController, :current_user
    end
  end

  scope "/", MyApp do
    pipe_through :browser # Use the default browser stack

    get "*path", PageController, :index
  end
end
