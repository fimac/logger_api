defmodule LoggerApiWeb.GraphqlWSSocket do
  use Absinthe.GraphqlWS.Socket, schema: LoggerApiWeb.Schema

  @impl Absinthe.GraphqlWS.Socket
  def handle_message({:internal_thing, id}, socket) do
    {:ok, assign(socket, :message, id)}
  end

  def handle_message({:external_thing, _id}, socket) do
    {:push, {:text, "{}"}, socket}
  end
end
