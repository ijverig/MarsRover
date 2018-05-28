defmodule MarsRover.MixProject do
  use Mix.Project

  def project do
    [
      app: :mars_rover,
      version: "2.2.0",
      elixir: "~> 1.6",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      escript: escript()
    ]
  end

  def application do
    [
      extra_applications: [:logger]
    ]
  end

  defp deps do
    [
      {:mix_test_watch, "~> 0.6", only: :dev, runtime: false},
      {:credo, "~> 0.9.2", only: [:dev, :test], runtime: false}
    ]
  end

  defp escript do
    [
      main_module: MarsRover.CLI,
      emu_args: "-elixir ansi_enabled true"
    ]
  end
end
