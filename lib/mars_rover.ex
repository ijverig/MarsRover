defmodule MarsRover do
  alias MarsRover.Deployments

  def deploy(plateau, deployments), do: Deployments.deploy_several(deployments, plateau)

  def version, do: Keyword.get(Mix.Project.config(), :version)
end
