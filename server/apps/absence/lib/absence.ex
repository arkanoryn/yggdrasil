defmodule Absence do
  # TODO
  @moduledoc """
  """

  @type kind :: :vacation | :disease | :special_leave
  @type status :: :pending | :granted | :refused | :canceled

  def start(type, args) do
    Absence.Application.start(type, args)
  end
end
