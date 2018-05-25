defmodule MarsRover do
  alias MarsRover.Deployments

  def deploy(plateau, deployments), do: Deployments.deploy_several(deployments, plateau)

  def version do
    {:ok, version} = :application.get_key(:mars_rover, :vsn)
    to_string(version)
  end
end
