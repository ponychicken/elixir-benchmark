defmodule BenchmarkingWeb.ObjectControllerTest do
  use BenchmarkingWeb.ConnCase

  import Benchmarking.ObjectsFixtures

  alias Benchmarking.Objects.Object

  @create_attrs %{
    deleted_at: ~U[2024-05-15 08:52:00Z]
  }
  @update_attrs %{
    deleted_at: ~U[2024-05-16 08:52:00Z]
  }
  @invalid_attrs %{deleted_at: nil}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all objects", %{conn: conn} do
      conn = get(conn, ~p"/api/objects")
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create object" do
    test "renders object when data is valid", %{conn: conn} do
      conn = post(conn, ~p"/api/objects", object: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, ~p"/api/objects/#{id}")

      assert %{
               "id" => ^id,
               "deleted_at" => "2024-05-15T08:52:00Z"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, ~p"/api/objects", object: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update object" do
    setup [:create_object]

    test "renders object when data is valid", %{conn: conn, object: %Object{id: id} = object} do
      conn = put(conn, ~p"/api/objects/#{object}", object: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, ~p"/api/objects/#{id}")

      assert %{
               "id" => ^id,
               "deleted_at" => "2024-05-16T08:52:00Z"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, object: object} do
      conn = put(conn, ~p"/api/objects/#{object}", object: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete object" do
    setup [:create_object]

    test "deletes chosen object", %{conn: conn, object: object} do
      conn = delete(conn, ~p"/api/objects/#{object}")
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, ~p"/api/objects/#{object}")
      end
    end
  end

  defp create_object(_) do
    object = object_fixture()
    %{object: object}
  end
end
