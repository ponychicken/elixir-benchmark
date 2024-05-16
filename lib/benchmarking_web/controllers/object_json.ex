defmodule BenchmarkingWeb.ObjectJSON do
  alias Benchmarking.Objects.Object

  @doc """
  Renders a list of objects.
  """
  def index(%{objects: objects}) do
    %{data: for(object <- objects, do: data(object))}
  end

  @doc """
  Renders a single object.
  """
  def show(%{object: object}) do
    %{data: data(object)}
  end

  defp data(%Object{} = object) do
    %{
      id: object.id,
      deleted_at: object.deleted_at
    }
  end
end
