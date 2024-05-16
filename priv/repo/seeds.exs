# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     Benchmarking.Repo.insert!(%Benchmarking.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.
for _ <- 1..500000 do
  Benchmarking.Repo.insert!(%Benchmarking.Objects.Object{
    deleted_at: DateTime.truncate(DateTime.utc_now(), :second)
  })
end
