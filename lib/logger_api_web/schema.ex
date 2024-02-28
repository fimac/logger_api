defmodule LoggerApiWeb.Schema do
  use Absinthe.Schema

  alias LoggerApiWeb.AuditLogsResolver

  object :event do
    field :id, non_null(:id)
    field :identity, non_null(:string)
    field :table, non_null(:string)
    field :database, non_null(:string)
    field :query, non_null(:string)
  end

  query do
    @desc "Get all events"
    field :all_events, non_null(list_of(non_null(:event))) do
      resolve(&AuditLogsResolver.all_events/3)
    end
  end

  subscription do
    field :event_added, :event do
      arg(:database, non_null(:string))
      # used to configure the subscription field.
      # perform other checks like authorization to accept/reject the subscription
      config(fn %{database: database}, %{context: _context} ->
        {:ok, topic: "event:#{database}"}
      end)
    end
  end
end
