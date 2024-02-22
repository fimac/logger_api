defmodule LoggerApi.AuditLogsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `LoggerApi.AuditLogs` context.
  """

  @doc """
  Generate a event.
  """
  def event_fixture(attrs \\ %{}) do
    {:ok, event} =
      attrs
      |> Enum.into(%{
        database: "some database",
        identity: "some identity",
        query: "some query",
        table: "some table",
        timestamp: ~N[2024-02-21 03:28:00]
      })
      |> LoggerApi.AuditLogs.create_event()

    event
  end
end
