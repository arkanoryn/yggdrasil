defmodule Absence.Application do
  # See http://elixir-lang.org/docs/stable/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  alias Db.Providers.AbsenceProvider

  def start(_type, _args) do
    import Supervisor.Spec, warn: false

    children = [ worker(AbsenceProvider, [:absence_provider])]
    opts     = [ strategy: :one_for_one, name: Absence.Supervisor ]

    Supervisor.start_link(children, opts)
  end
end
