# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     LoggerApi.Repo.insert!(%LoggerApi.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

alias LoggerApi.AuditLogs.Event
alias LoggerApi.Repo

%Event{
  timestamp: ~N[2000-01-01 23:00:07],
  identity: "Grace Hopper",
  table: "users",
  database: "perx_prod",
  query: "SELECT * FROM users WHERE name = 'xxxxxx'"
}
|> Repo.insert!()

%Event{
  timestamp: ~N[2000-01-01 23:00:07],
  identity: "Grace Hopper",
  table: "users",
  database: "perx_prod",
  query: "SELECT * FROM users WHERE name = 'xxxxxx'"
}
|> Repo.insert!()

%Event{
  timestamp: ~N[2000-01-01 23:00:07],
  identity: "Ada Lovelace",
  table: "users",
  database: "perx_prod",
  query: "SELECT * FROM users WHERE name = 'xxxxxx'"
}
|> Repo.insert!()

# only for testing use utc_time.
%Event{
  timestamp: ~N[2000-01-01 23:00:07],
  identity: "Ada Lovelace",
  table: "users",
  database: "perx_prod",
  query: "SELECT * FROM users WHERE name = 'xxxxxx'"
}
|> Repo.insert!()
