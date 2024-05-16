defmodule Benchmarking.Repo do
  use Ecto.Repo,
    otp_app: :benchmarking,
    adapter: Ecto.Adapters.Postgres
end
