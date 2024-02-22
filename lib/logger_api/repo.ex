defmodule LoggerApi.Repo do
  use Ecto.Repo,
    otp_app: :logger_api,
    adapter: Ecto.Adapters.Postgres
end
