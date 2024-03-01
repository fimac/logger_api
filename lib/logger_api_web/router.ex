defmodule LoggerApiWeb.Router do
  use LoggerApiWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/" do
    pipe_through :api

    forward "/graphiql", Absinthe.Plug.GraphiQL,
      schema: LoggerApiWeb.Schema,
      socket: LoggerApiWeb.GraphqlWSSocket,
      interface: :simple,
      context: %{pubsub: LoggerApiWeb.Endpoint}

    forward "/api/graphql-ws/websocket", Absinthe.GraphqlWS.Socket,
      schema: LoggerApiWeb.Schema,
      socket: LoggerApiWeb.GraphqlWSSocket
  end
end
