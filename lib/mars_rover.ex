defmodule MarsRover do
  alias MarsRover.{Deployments, Plateau}

  def deploy(plateau_limits, deployments) do
    Plateau.start_link(plateau_limits)
    Deployments.deploy_several(deployments)
  end

  def version, do: Keyword.get(Mix.Project.config(), :version)
end
