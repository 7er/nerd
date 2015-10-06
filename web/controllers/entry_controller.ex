defmodule Nerd.EntryController do
  use Nerd.Web, :controller

  alias Nerd.Entry

  plug :scrub_params, "entry" when action in [:create, :update]

  def index(conn, %{"list_id" => list_id}) do
    entries = Repo.all(Entry)
    render(conn, "index.html", list_id: list_id, entries: entries)
  end

  def new(conn, %{"list_id" => list_id}) do
    changeset = Entry.changeset(%Entry{})
    render(conn, "new.html", list_id: list_id, changeset: changeset)
  end

  def create(conn, %{"entry" => entry_params, "list_id" => list_id}) do
    changeset = Entry.changeset(%Entry{}, entry_params)

    case Repo.insert(changeset) do
      {:ok, _entry} ->
        conn
        |> put_flash(:info, "Entry created successfully.")
        |> redirect(to: list_entry_path(conn, :index, list_id))
      {:error, changeset} ->
        render(conn, "new.html", list_id, changeset: changeset)
    end
  end

  def show(conn, %{"list_id" => list_id, "id" => id}) do
    entry = Repo.get!(Entry, id)
    render(conn, "show.html", list_id: list_id, entry: entry)
  end

  def edit(conn, %{"list_id" => list_id, "id" => id}) do
    entry = Repo.get!(Entry, id)
    changeset = Entry.changeset(entry)
    render(conn, "edit.html", list_id: list_id, entry: entry, changeset: changeset)
  end

  def update(conn, %{"list_id" => list_id, "id" => id, "entry" => entry_params}) do
    entry = Repo.get!(Entry, id)
    changeset = Entry.changeset(entry, entry_params)

    case Repo.update(changeset) do
      {:ok, entry} ->
        conn
        |> put_flash(:info, "Entry updated successfully.")
        |> redirect(to: list_entry_path(conn, :show, list_id, entry))
      {:error, changeset} ->
        render(conn, "edit.html", list_id: list_id, entry: entry, changeset: changeset)
    end
  end

  def delete(conn, %{"list_id" => list_id, "id" => id}) do
    entry = Repo.get!(Entry, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(entry)

    conn
    |> put_flash(:info, "Entry deleted successfully.")
    |> redirect(to: list_entry_path(conn, :index, list_id))
  end
end
