defmodule LoggerApiWeb.AuditLogsResolver do
  alias LoggerApi.AuditLogs

  def all_events(_root, _args, _info) do
    {:ok, AuditLogs.list_events()}
  end
end
