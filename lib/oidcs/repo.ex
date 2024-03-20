defmodule OIDCS.Repo do
  use Ecto.Repo,
    otp_app: :oidcs,
    adapter: Ecto.Adapters.Postgres
end
