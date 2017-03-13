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
    get "/accepted_absences", AbsenceController, :all_accepted
    resources "/absences", AbsenceController, except: [:new, :edit]
    resources "/contracts", ContractController, except: [:new, :edit]
  end

  if Mix.env == :dev do
    forward "/sent_emails", Bamboo.EmailPreviewPlug
  end
end
