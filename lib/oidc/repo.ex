defmodule OIDC.Repo do
  use Ecto.Repo,
    otp_app: :oidc,
    adapter: Ecto.Adapters.Postgres
end
