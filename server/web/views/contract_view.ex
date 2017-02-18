defmodule Server.ContractView do
  use Server.Web, :view

  def render("index.json", %{contracts: contracts}) do
    %{data: render_many(contracts, Server.ContractView, "contract.json")}
  end

  def render("show.json", %{contract: contract}) do
    %{data: render_one(contract, Server.ContractView, "contract.json")}
  end

  def render("contract.json", %{contract: contract}) do
    %{id: contract.id,
      user_id: contract.user_id,
      year: contract.year,
      vacation_days: contract.vacation_days}
  end
end
