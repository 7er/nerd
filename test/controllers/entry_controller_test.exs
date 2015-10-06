defmodule Nerd.EntryControllerTest do
  use Nerd.ConnCase

  alias Nerd.Entry
  alias Nerd.List

  @valid_attrs %{text: "some content"}
  @invalid_attrs %{}

  setup do
    conn = conn()
    list = Repo.insert!(%List{text: "Svensk"})
    {:ok, conn: conn, list: list}
  end

  test "lists all entries on index", %{conn: conn, list: list} do
    conn = get conn, list_entry_path(conn, :index, list.id)
    assert html_response(conn, 200) =~ "Listing entries"
  end

  test "renders form for new resources", %{conn: conn, list: list} do
    conn = get conn, list_entry_path(conn, :new, list.id)
    assert html_response(conn, 200) =~ "New entry"
  end

  test "creates resource and redirects when data is valid", %{conn: conn, list: list} do
    path = list_entry_path(conn, :create, list)
    IO.puts(path)
    conn = post conn, path, entry: @valid_attrs
    assert redirected_to(conn) == list_entry_path(conn, :index, list)
    assert Repo.get_by(Entry, @valid_attrs)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn, list: list} do
    conn = post conn, list_entry_path(conn, :create, list), entry: @invalid_attrs
    assert html_response(conn, 200) =~ "New entry"
  end

  test "shows chosen resource", %{conn: conn, list: list} do
    entry = Repo.insert! %Entry{list_id: list.id}
    conn = get conn, list_entry_path(conn, :show, list, entry)
    assert html_response(conn, 200) =~ "Show entry"
  end

  test "renders page not found when id is nonexistent", %{conn: conn, list: list} do
    assert_raise Ecto.NoResultsError, fn ->
      get conn, list_entry_path(conn, :show, list, -1)
    end
  end

  test "renders form for editing chosen resource", %{conn: conn, list: list} do
    entry = Repo.insert! %Entry{list_id: list.id}
    conn = get conn, list_entry_path(conn, :edit, list, entry)
    assert html_response(conn, 200) =~ "Edit entry"
  end

  test "updates chosen resource and redirects when data is valid", %{conn: conn, list: list} do
    entry = Repo.insert! %Entry{list_id: list.id}
    conn = put conn, list_entry_path(conn, :update, list, entry), entry: @valid_attrs
    assert redirected_to(conn) == list_entry_path(conn, :show, list, entry)
    assert Repo.get_by(Entry, @valid_attrs)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn, list: list} do
    entry = Repo.insert! %Entry{}
    conn = put conn, list_entry_path(conn, :update, list, entry), entry: @invalid_attrs
    assert html_response(conn, 200) =~ "Edit entry"
  end

  test "deletes chosen resource", %{conn: conn, list: list} do
    entry = Repo.insert! %Entry{}
    conn = delete conn, list_entry_path(conn, :delete, list, entry)
    assert redirected_to(conn) == list_entry_path(conn, :index, list)
    refute Repo.get(Entry, entry.id)
  end
end
