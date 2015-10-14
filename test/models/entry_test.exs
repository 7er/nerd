defmodule Nerd.EntryTest do
  use Nerd.ModelCase

  alias Nerd.Entry
  alias Nerd.List

  @valid_attrs %{text: "some content"}
  @invalid_attrs %{}

  setup do
    list = Repo.insert!(%List{text: "Svensk"})
    {:ok, list: list}
  end

  test "changeset with valid attributes", %{list: list} do
    changeset = Entry.changeset(%Entry{}, Dict.put(@valid_attrs, :list_id, list.id))
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Entry.changeset(%Entry{}, @invalid_attrs)
    refute changeset.valid?
  end
end
