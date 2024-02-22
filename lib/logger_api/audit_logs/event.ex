defmodule LoggerApi.AuditLogs.Event do
  use Ecto.Schema
  import Ecto.Changeset

  schema "events" do
    field :table, :string
    field :timestamp, :naive_datetime
    field :query, :string
    field :database, :string
    field :identity, :string

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(event, attrs) do
    event
    |> cast(attrs, [:timestamp, :identity, :table, :database, :query])
    |> validate_required([:timestamp, :identity, :table, :database, :query])
  end
end
