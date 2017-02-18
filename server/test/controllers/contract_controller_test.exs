defmodule Server.ContractControllerTest do
  use Server.ConnCase

  alias Server.Contract
  @valid_attrs %{vacation_days: 42, year: %{day: 17, month: 4, year: 2010}}
  @invalid_attrs %{}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, contract_path(conn, :index)
    assert json_response(conn, 200)["data"] == []
  end

  test "shows chosen resource", %{conn: conn} do
    contract = Repo.insert! %Contract{}
    conn = get conn, contract_path(conn, :show, contract)
    assert json_response(conn, 200)["data"] == %{"id" => contract.id,
      "user_id" => contract.user_id,
      "year" => contract.year,
      "vacation_days" => contract.vacation_days}
  end

  test "renders page not found when id is nonexistent", %{conn: conn} do
    assert_error_sent 404, fn ->
      get conn, contract_path(conn, :show, -1)
    end
  end

  test "creates and renders resource when data is valid", %{conn: conn} do
    conn = post conn, contract_path(conn, :create), contract: @valid_attrs
    assert json_response(conn, 201)["data"]["id"]
    assert Repo.get_by(Contract, @valid_attrs)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, contract_path(conn, :create), contract: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "updates and renders chosen resource when data is valid", %{conn: conn} do
    contract = Repo.insert! %Contract{}
    conn = put conn, contract_path(conn, :update, contract), contract: @valid_attrs
    assert json_response(conn, 200)["data"]["id"]
    assert Repo.get_by(Contract, @valid_attrs)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    contract = Repo.insert! %Contract{}
    conn = put conn, contract_path(conn, :update, contract), contract: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "deletes chosen resource", %{conn: conn} do
    contract = Repo.insert! %Contract{}
    conn = delete conn, contract_path(conn, :delete, contract)
    assert response(conn, 204)
    refute Repo.get(Contract, contract.id)
  end
end
