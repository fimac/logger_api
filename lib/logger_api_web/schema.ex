defmodule LoggerApiWeb.Schema do
  use Absinthe.Schema

  alias LoggerApiWeb.NewsResolver

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
      resolve(&AuditLogResolver.all_links/3)
    end
  end
end
