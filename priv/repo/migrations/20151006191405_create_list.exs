defmodule Nerd.Repo.Migrations.CreateList do
  use Ecto.Migration

  def change do
    create table(:lists) do
      add :text, :string

      timestamps
    end

  end
end
