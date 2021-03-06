defmodule Nerd.Entry do
  use Nerd.Web, :model

  schema "entries" do
    field :text, :string
    belongs_to :list, Nerd.List

    timestamps
  end

  @required_fields ~w(text list_id)
  @optional_fields ~w()

  @doc """
  Creates a changeset based on the `model` and `params`.

  If no params are provided, an invalid changeset is returned
  with no validation performed.
  """
  def changeset(model, params \\ :empty) do
    model
    |> cast(params, @required_fields, @optional_fields)
  end
end
