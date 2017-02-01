defmodule Api.AbsenceControllerTest do
  use Api.ConnCase

  # alias Api.Absence
  # @valid_attrs %{kind: 42}
  # @invalid_attrs %{}

  # setup %{conn: conn} do
  #   {:ok, conn: put_req_header(conn, "accept", "application/json")}
  # end

  test "Receive mock" do
    assert Absence.mock() == %{kind: 1}
  end

  # test "lists all entries on index", %{conn: conn} do
  #   conn = get conn, absence_path(conn, :index)
  #   assert json_response(conn, 200)["data"] == []
  # end

  # test "shows chosen resource", %{conn: conn} do
  #   absence = Repo.insert! %Absence{}
  #   conn = get conn, absence_path(conn, :show, absence)
  #   assert json_response(conn, 200)["data"] == %{"id" => absence.id,
  #     "kind" => absence.kind}
  # end

  # test "renders page not found when id is nonexistent", %{conn: conn} do
  #   assert_error_sent 404, fn ->
  #     get conn, absence_path(conn, :show, -1)
  #   end
  # end

  # test "creates and renders resource when data is valid", %{conn: conn} do
  #   conn = post conn, absence_path(conn, :create), absence: @valid_attrs
  #   assert json_response(conn, 201)["data"]["id"]
  #   assert Repo.get_by(Absence, @valid_attrs)
  # end

  # test "does not create resource and renders errors when data is invalid", %{conn: conn} do
  #   conn = post conn, absence_path(conn, :create), absence: @invalid_attrs
  #   assert json_response(conn, 422)["errors"] != %{}
  # end

  # test "updates and renders chosen resource when data is valid", %{conn: conn} do
  #   absence = Repo.insert! %Absence{}
  #   conn = put conn, absence_path(conn, :update, absence), absence: @valid_attrs
  #   assert json_response(conn, 200)["data"]["id"]
  #   assert Repo.get_by(Absence, @valid_attrs)
  # end

  # test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
  #   absence = Repo.insert! %Absence{}
  #   conn = put conn, absence_path(conn, :update, absence), absence: @invalid_attrs
  #   assert json_response(conn, 422)["errors"] != %{}
  # end

  # test "deletes chosen resource", %{conn: conn} do
  #   absence = Repo.insert! %Absence{}
  #   conn = delete conn, absence_path(conn, :delete, absence)
  #   assert response(conn, 204)
  #   refute Repo.get(Absence, absence.id)
  # end
end
