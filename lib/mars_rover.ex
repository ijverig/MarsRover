defmodule MarsRover do
  alias MarsRover.{Deployments, Plateau}

  def deploy(plateau_limits, deployments) do
    Plateau.start(plateau_limits)
    results = Deployments.deploy_several(deployments)
    Plateau.stop()

    results
  end

  def version, do: Keyword.get(Mix.Project.config(), :version)
end
