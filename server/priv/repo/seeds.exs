# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     Server.Repo.insert!(%Server.SomeModel{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.
alias Server.Repo

kind_list = ["disease", "vacation", "special_leave"]
status_list = ["accepted", "refused", "pending"]


user = %Server.User{}
|> Server.User.registration_changeset(%{ username: "arkanoryn", email: "arkanoryn@test.com", password: "1234567890" })
|> Repo.insert!

for _ <- 1..3 do
    Repo.insert!(
      %Server.Absence
      {
        kind: Enum.random(kind_list),
        status: Enum.random(status_list),
        begin_on: Timex.today,
        end_on: Timex.today,
        half_day: false,
        user_id: user.id
      }
    )
end


user2 = %Server.User{}
|> Server.User.registration_changeset(%{ username: "bck", email: "bck@test.com", password: "1234567890" })
|> Repo.insert!

for _ <- 1..5 do
    Repo.insert!(
      %Server.Absence
      {
        kind: Enum.random(kind_list),
        status: Enum.random(status_list),
        begin_on: Timex.today,
        end_on: Timex.today,
        half_day: false,
        user_id: user2.id
      }
    )
end
