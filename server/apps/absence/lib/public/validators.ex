defmodule Absence.Public.Validators do
  def valid_absence?(%{"kind" => kind, "begin_on" => begin_on, "end_on" => end_on}) do
    valid_kind?(kind) && valid_dates?(begin_on, end_on)
  end

  @spec valid_kind?(String.t) :: boolean
  defp valid_kind?(_kind) do
    true
  end

  @spec valid_dates?(String.t, String.t) :: boolean
  defp valid_dates?(begin_on, end_on) do
    begin_on = to_date(begin_on)
    end_on = to_date(end_on)

    Timex.before?(Timex.today, begin_on) &&
    (Timex.compare(begin_on, end_on) == 0 || Timex.before?(begin_on, end_on))
  end

  @spec to_date(String.t) :: Date.t
  defp to_date(date) do
    date
    |> Timex.parse!("%Y-%m-%d", :strftime)
    |> Timex.to_date
  end
end
