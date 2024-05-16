defmodule Benchmarking.ObjectsTest do
  use Benchmarking.DataCase

  alias Benchmarking.Objects

  describe "objects" do
    alias Benchmarking.Objects.Object

    import Benchmarking.ObjectsFixtures

    @invalid_attrs %{deleted_at: nil}

    test "list_objects/0 returns all objects" do
      object = object_fixture()
      assert Objects.list_objects() == [object]
    end

    test "get_object!/1 returns the object with given id" do
      object = object_fixture()
      assert Objects.get_object!(object.id) == object
    end

    test "create_object/1 with valid data creates a object" do
      valid_attrs = %{deleted_at: ~U[2024-05-15 08:52:00Z]}

      assert {:ok, %Object{} = object} = Objects.create_object(valid_attrs)
      assert object.deleted_at == ~U[2024-05-15 08:52:00Z]
    end

    test "create_object/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Objects.create_object(@invalid_attrs)
    end

    test "update_object/2 with valid data updates the object" do
      object = object_fixture()
      update_attrs = %{deleted_at: ~U[2024-05-16 08:52:00Z]}

      assert {:ok, %Object{} = object} = Objects.update_object(object, update_attrs)
      assert object.deleted_at == ~U[2024-05-16 08:52:00Z]
    end

    test "update_object/2 with invalid data returns error changeset" do
      object = object_fixture()
      assert {:error, %Ecto.Changeset{}} = Objects.update_object(object, @invalid_attrs)
      assert object == Objects.get_object!(object.id)
    end

    test "delete_object/1 deletes the object" do
      object = object_fixture()
      assert {:ok, %Object{}} = Objects.delete_object(object)
      assert_raise Ecto.NoResultsError, fn -> Objects.get_object!(object.id) end
    end

    test "change_object/1 returns a object changeset" do
      object = object_fixture()
      assert %Ecto.Changeset{} = Objects.change_object(object)
    end
  end
end
