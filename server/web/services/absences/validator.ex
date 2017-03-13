defmodule Server.Services.Absences.Validator do
  @kinds ["disease", "vacation", "special_leave"]
  @statuses ["accepted", "refused", "pending", "canceled"]

  def valid_kind?(kind) do
    Enum.member?(@kinds, kind)
  end

  def valid_status?(status) do
    Enum.member?(@statuses, status)
  end

  def validate_absence(params) do
    {:ok, params}
    |> validate_kind
    |> validate_status
    |> validate_dates
  end

  def validate_kind({:ok, params}) do
    case valid_kind?(params["kind"]) do
      true  -> {:ok, params}
      false -> {:error, params, ["Invalid kind."]}
    end
  end

  def validate_kind({:error, params, msgs}) do
    case valid_kind?(params["kind"]) do
      true  -> {:error, params, msgs}
      false -> {:error, params, msgs ++ ["Invalid kind."]}
    end
  end

  def validate_status({:ok, params}) do
    case valid_status?(params["status"]) do
      true  -> {:ok, params}
      false -> {:error, params, ["Invalid status."]}
    end
  end

  def validate_status({:error, params, msgs}) do
    case valid_status?(params["status"]) do
      true  -> {:error, params, msgs}
      false -> {:error, params, msgs ++ ["Invalid status."]}
    end
  end

  def validate_dates({:ok, params}) do
    begin_on = to_date(params["begin_on"])
    end_on   = to_date(params["end_on"])
    {status, msgs} =
    {:ok, begin_on, end_on}
    |> begin_after_today
    |> end_after_beginning

    case status do
      :ok    -> {:ok, params}
      :error -> {:error, params, msgs}
    end
  end

  def validate_dates({:error, params, original_msgs}) do
    begin_on = to_date(params["begin_on"])
    end_on   = to_date(params["end_on"])
    {status, msgs} =
    {:ok, begin_on, end_on}
    |> begin_after_today
    |> end_after_beginning

    case status do
      :ok    -> {:error, params, original_msgs}
      :error -> {:error, params, original_msgs ++ msgs}
    end
  end

  defp begin_after_today({:ok, begin_on, end_on}) do
    case Timex.compare(Timex.today, begin_on) <= 0 do
      true  -> {:ok, begin_on, end_on}
      false -> {:error, begin_on, end_on, ["Vacation starting date must be today or later."]}
    end
  end

  defp end_after_beginning({:ok, begin_on, end_on}) do
    case (Timex.compare(begin_on, end_on) == 0 || Timex.before?(begin_on, end_on)) do
      true  -> {:ok, []}
      false -> {:error, ["Ending date must be greater or equal to the begin date."]}
    end
  end

  defp end_after_beginning({:error, begin_on, end_on, msgs}) do
    case (Timex.compare(begin_on, end_on) == 0 || Timex.before?(begin_on, end_on)) do
      true  -> {:error, msgs}
      false -> {:error, msgs ++ ["Ending date must be greater or equal to the begin date."]}
    end
  end

  # TODO - write doc
  defp to_date(date) do
    date
    |> Timex.parse!("%Y-%m-%d", :strftime)
    |> Timex.to_date
  end
end
