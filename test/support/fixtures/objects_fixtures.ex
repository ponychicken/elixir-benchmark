defmodule Benchmarking.ObjectsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Benchmarking.Objects` context.
  """

  @doc """
  Generate a object.
  """
  def object_fixture(attrs \\ %{}) do
    {:ok, object} =
      attrs
      |> Enum.into(%{
        deleted_at: ~U[2024-05-15 08:52:00Z]
      })
      |> Benchmarking.Objects.create_object()

    object
  end
end
