defmodule Server.Router do
  use Server.Web, :router

  pipeline :visitor do
    plug :accepts, ["json"]
  end

  pipeline :api do
    plug :accepts, ["json"]
    plug Guardian.Plug.VerifyHeader, realm: "Bearer"
    plug Guardian.Plug.LoadResource
  end

  scope "/api", Server do
    pipe_through :visitor

  post "/sessions/new", SessionController, :login
  end

  scope "/api", Server do
    pipe_through :api

    resources "/users", UserController, except: [:new, :edit]
    resources "/absences", AbsenceController, except: [:new, :edit]
    resources "/contracts", ContractController, except: [:new, :edit]
  end
end
