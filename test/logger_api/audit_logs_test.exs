defmodule LoggerApi.AuditLogsTest do
  use LoggerApi.DataCase

  alias LoggerApi.AuditLogs

  describe "events" do
    alias LoggerApi.AuditLogs.Event

    import LoggerApi.AuditLogsFixtures

    @invalid_attrs %{table: nil, timestamp: nil, query: nil, database: nil, identity: nil}

    test "list_events/0 returns all events" do
      event = event_fixture()
      assert AuditLogs.list_events() == [event]
    end

    test "get_event!/1 returns the event with given id" do
      event = event_fixture()
      assert AuditLogs.get_event!(event.id) == event
    end

    test "create_event/1 with valid data creates a event" do
      valid_attrs = %{table: "some table", timestamp: ~N[2024-02-21 03:28:00], query: "some query", database: "some database", identity: "some identity"}

      assert {:ok, %Event{} = event} = AuditLogs.create_event(valid_attrs)
      assert event.table == "some table"
      assert event.timestamp == ~N[2024-02-21 03:28:00]
      assert event.query == "some query"
      assert event.database == "some database"
      assert event.identity == "some identity"
    end

    test "create_event/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = AuditLogs.create_event(@invalid_attrs)
    end

    test "update_event/2 with valid data updates the event" do
      event = event_fixture()
      update_attrs = %{table: "some updated table", timestamp: ~N[2024-02-22 03:28:00], query: "some updated query", database: "some updated database", identity: "some updated identity"}

      assert {:ok, %Event{} = event} = AuditLogs.update_event(event, update_attrs)
      assert event.table == "some updated table"
      assert event.timestamp == ~N[2024-02-22 03:28:00]
      assert event.query == "some updated query"
      assert event.database == "some updated database"
      assert event.identity == "some updated identity"
    end

    test "update_event/2 with invalid data returns error changeset" do
      event = event_fixture()
      assert {:error, %Ecto.Changeset{}} = AuditLogs.update_event(event, @invalid_attrs)
      assert event == AuditLogs.get_event!(event.id)
    end

    test "delete_event/1 deletes the event" do
      event = event_fixture()
      assert {:ok, %Event{}} = AuditLogs.delete_event(event)
      assert_raise Ecto.NoResultsError, fn -> AuditLogs.get_event!(event.id) end
    end

    test "change_event/1 returns a event changeset" do
      event = event_fixture()
      assert %Ecto.Changeset{} = AuditLogs.change_event(event)
    end
  end
end
