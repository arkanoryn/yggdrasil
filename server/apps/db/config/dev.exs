use Mix.Config

config :db, Db.Repo,
  adapter: Ecto.Adapters.Postgres,
  username: "postgres",
  password: "postgres",
  database: "dev_yggdrasil_db",
  hostname: "localhost",
  pool_size: 10
