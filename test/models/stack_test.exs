defmodule MyApp.StackTest do
  use MyApp.ModelCase

  alias MyApp.Stack

  @valid_attrs %{name: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Stack.changeset(%Stack{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Stack.changeset(%Stack{}, @invalid_attrs)
    refute changeset.valid?
  end
end
