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

  # Just for testing flow
  object :event_mutation_result do
    field :event, :event
    # field :errors, list_of(non_null(:string))
  end

  # Just for testing flow
  input_object :event_create_input do
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

  # Just for testing, we will not be using mutations to trigger
  # We can use Absinthe.subscription publish.
  mutation do
    field :create_event, non_null(:event_mutation_result) do
      arg(:event, non_null(:event_create_input))

      resolve(&AuditLogsResolver.create_event/3)
    end
  end

  # would return a list of events.
  subscription do
    field :event_added, :event do
      arg(:database, non_null(:string))
      # used to configure the subscription field.
      # perform other checks like authorization to accept/reject the subscription
      config(fn %{database: database}, %{context: _context} ->
        IO.inspect(database, label: "hitting the config in the subscription")
        {:ok, topic: "event:#{database}"}
      end)

      # accepts the name of a mutation to trigger the subscription and a topic function.
      trigger(:create_event,
        topic: fn %{event: %{database: database}} ->
          IO.inspect(database, label: "Database######")
          "event:#{database}"
        end
      )

      resolve(fn %{event: event}, _args, _resolution ->
        {:ok, event}
      end)
    end
  end
end
