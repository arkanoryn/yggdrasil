defmodule Absence do
  @moduledoc false

  def start(type, args) do
    Absence.Application.start(type, args)
  end
end
