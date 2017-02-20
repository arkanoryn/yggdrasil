defmodule Server.SessionController do
  use Server.Web, :controller

  plug :scrub_params, "user" when action in [:create]

  def login(conn, params) do
    case Server.User.find_and_confirm_password(params) do
      {:ok, user} ->
        new_conn      = Guardian.Plug.api_sign_in(conn, user)
        token         = Guardian.Plug.current_token(new_conn)
        # {:ok, claims} = Guardian.Plug.claims(new_conn)
        # exp           = Map.get(claims, "exp")

        new_conn
        |> put_resp_header("authorization", "Bearer #{token}")
        |> render("login.json", %{user: user, token: token})
      {:error, _changeset} ->
        conn
        |> put_status(401)
        |> render("error.json", message: "Could not login")
    end
  end
end
