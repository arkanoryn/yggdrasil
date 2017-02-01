defmodule Api.Router do
  use Api.Web, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", Api do
    pipe_through :api

    resources "/absences", AbsenceController, except: [:new, :edit]
  end
end
