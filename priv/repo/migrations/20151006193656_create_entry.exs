defmodule Nerd.Repo.Migrations.CreateEntry do
  use Ecto.Migration

  def change do
    create table(:entries) do
      add :text, :string
      add :list_id, references(:lists)

      timestamps
    end
    create index(:entries, [:list_id])

  end
end
