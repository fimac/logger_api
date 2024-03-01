defmodule LoggerApiWeb.Endpoint do
  use Phoenix.Endpoint, otp_app: :logger_api
  use Absinthe.Phoenix.Endpoint

  # The session will be stored in the cookie and signed,
  # this means its contents can be read but not tampered with.
  # Set :encryption_salt if you would also like to encrypt it.
  @session_options [
    store: :cookie,
    key: "_logger_api_key",
    signing_salt: "KR1qurDB",
    same_site: "Lax"
  ]

  # The socket ties transports and channels together.

  # By default, Phoenix uses WebSockets instead of long-polling, but it comes with support for both.
  # Notice websockets: true and longpolling: false in the socket method.
  socket "/socket", LoggerApiWeb.UserSocket,
    websocket: [connect_info: [session: @session_options]],
    longpoll: [connect_info: [session: @session_options]]

  socket "/api/graphql-ws", LoggerApiWeb.GraphqlWSSocket,
    websocket: [path: "", subprotocols: ["graphql-transport-ws"]],
    longpoll: [connect_info: [session: @session_options]]

  socket "/live", Phoenix.LiveView.Socket,
    websocket: [connect_info: [session: @session_options]],
    longpoll: [connect_info: [session: @session_options]]

  # Serve at "/" the static files from "priv/static" directory.
  #
  # You should set gzip to true if you are running phx.digest
  # when deploying your static files in production.
  plug Plug.Static,
    at: "/",
    from: :logger_api,
    gzip: false,
    only: LoggerApiWeb.static_paths()

  # Code reloading can be explicitly enabled under the
  # :code_reloader configuration of your endpoint.
  if code_reloading? do
    plug Phoenix.CodeReloader
    plug Phoenix.Ecto.CheckRepoStatus, otp_app: :logger_api
  end

  plug Phoenix.LiveDashboard.RequestLogger,
    param_key: "request_logger",
    cookie_key: "request_logger"

  plug Plug.RequestId
  plug Plug.Telemetry, event_prefix: [:phoenix, :endpoint]

  plug Plug.Parsers,
    parsers: [:urlencoded, :multipart, :json],
    pass: ["*/*"],
    json_decoder: Phoenix.json_library()

  plug Plug.MethodOverride
  plug Plug.Head
  plug Plug.Session, @session_options
  plug LoggerApiWeb.Router
end
