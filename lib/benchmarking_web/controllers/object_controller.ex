defmodule BenchmarkingWeb.ObjectController do
  use BenchmarkingWeb, :controller

  alias Benchmarking.Objects
  alias Benchmarking.Objects.Object

  action_fallback BenchmarkingWeb.FallbackController

  def index(conn, _params) do
    objects = Objects.list_objects()
    render(conn, :index, objects: objects)
  end

  def create(conn, %{"object" => object_params}) do
    with {:ok, %Object{} = object} <- Objects.create_object(object_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", ~p"/api/objects/#{object}")
      |> render(:show, object: object)
    end
  end

  def show(conn, %{"id" => id}) do
    object = Objects.get_object!(id)
    render(conn, :show, object: object)
  end

  def update(conn, %{"id" => id, "object" => object_params}) do
    object = Objects.get_object!(id)

    with {:ok, %Object{} = object} <- Objects.update_object(object, object_params) do
      render(conn, :show, object: object)
    end
  end

  def delete(conn, %{"id" => id}) do
    object = Objects.get_object!(id)

    with {:ok, %Object{}} <- Objects.delete_object(object) do
      send_resp(conn, :no_content, "")
    end
  end
end
