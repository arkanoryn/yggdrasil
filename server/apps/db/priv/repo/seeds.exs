alias Db.Repo

kind_list = ["disease", "vacation", "special_leave"]
status_list = ["accepted", "refused", "pending"]

for _ <- 1..3 do
    Repo.insert!(
      %Db.Absence.Model
      {
        kind: Enum.random(kind_list),
        status: Enum.random(status_list),
        begin_on: Timex.today,
        end_on: Timex.today,
        half_day: false
      }
    )
end
