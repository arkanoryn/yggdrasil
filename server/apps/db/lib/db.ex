defmodule Db do
  def start(type, args) do
    Db.Application.start(type, args)
  end
end
