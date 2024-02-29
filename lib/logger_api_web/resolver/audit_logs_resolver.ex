defmodule LoggerApiWeb.AuditLogsResolver do
  alias LoggerApi.AuditLogs

  def all_events(_root, _args, _info) do
    {:ok, AuditLogs.list_events()}
  end

  def create_event(_parent, event, _resolution) do
    # Just for testing flow.
    IO.inspect(event, label: "event===")
    {:ok, event}
  end
end
