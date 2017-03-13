defmodule Server.Services.Emails.Absence do
  import Bamboo.Email

  def on_create({absence, user}, admins) do
    base_email()
    |> to(admins)
    |> subject("New absence request from @#{user.username}")
    |> text_body(creation_text(absence, user))
    |> html_body(creation_html(absence, user))
  end

  defp base_email do
    new_email()
    |> from("Yggdrasil <yggdrasil@arkanoryn.com>")
    |> put_header("Reply-To", "no-reply@changelog.com")
  end

  defp creation_text(absence, user) do
    """
    User @#{user.username} made a `#{absence.kind}` request.

    The absence would be from: #{absence.begin_on} to #{absence.end_on}.
    """
  end

  defp creation_html(absence, user), do: creation_text(absence, user)
end
