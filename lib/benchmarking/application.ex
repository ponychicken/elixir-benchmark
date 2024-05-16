defmodule Benchmarking.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      BenchmarkingWeb.Telemetry,
      Benchmarking.Repo,
      {DNSCluster, query: Application.get_env(:benchmarking, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: Benchmarking.PubSub},
      # Start the Finch HTTP client for sending emails
      {Finch, name: Benchmarking.Finch},
      # Start a worker by calling: Benchmarking.Worker.start_link(arg)
      # {Benchmarking.Worker, arg},
      # Start to serve requests, typically the last entry
      BenchmarkingWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Benchmarking.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    BenchmarkingWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
