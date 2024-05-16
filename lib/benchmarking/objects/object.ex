defmodule Benchmarking.Objects.Object do
  use Ecto.Schema
  import Ecto.Changeset

  schema "objects" do
    field :deleted_at, :utc_datetime

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(object, attrs) do
    object
    |> cast(attrs, [:deleted_at])
    |> validate_required([:deleted_at])
  end
end
