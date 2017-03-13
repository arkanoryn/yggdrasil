defmodule Server.Services.Users.Admins do
  def list(:email) do
    ["arkanoryn@gmail.com", "test@test.com"]
  end
  def list(_), do: raise "undefined"
end
