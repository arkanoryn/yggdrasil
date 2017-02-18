defmodule Server.SessionView do
  use Server.Web, :view


  def render("login.json", %{user: user, token: token}) do
    %{data: %{user: %{id: user.id, username: user.username},
              token: token
             }
    }
  end
end
