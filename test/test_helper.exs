ExUnit.start

Mix.Task.run "ecto.create", ~w(-r CubesemServer.Repo --quiet)
Mix.Task.run "ecto.migrate", ~w(-r CubesemServer.Repo --quiet)
Ecto.Adapters.SQL.begin_test_transaction(CubesemServer.Repo)

