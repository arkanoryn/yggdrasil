defmodule Server.ContractController do
  use Server.Web, :controller

  alias Server.Contract

  def index(conn, _params) do
    contracts = Repo.all(Contract)
    render(conn, "index.json", contracts: contracts)
  end

  def create(conn, %{"contract" => contract_params}) do
    changeset = Contract.changeset(%Contract{}, contract_params)

    case Repo.insert(changeset) do
      {:ok, contract} ->
        conn
        |> put_status(:created)
        |> put_resp_header("location", contract_path(conn, :show, contract))
        |> render("show.json", contract: contract)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(Server.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    contract = Repo.get!(Contract, id)
    render(conn, "show.json", contract: contract)
  end

  def update(conn, %{"id" => id, "contract" => contract_params}) do
    contract = Repo.get!(Contract, id)
    changeset = Contract.changeset(contract, contract_params)

    case Repo.update(changeset) do
      {:ok, contract} ->
        render(conn, "show.json", contract: contract)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(Server.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    contract = Repo.get!(Contract, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(contract)

    send_resp(conn, :no_content, "")
  end
end
