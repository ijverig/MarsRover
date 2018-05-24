defmodule MarsRover do
  alias MarsRover.Deployments
  
  def process_deployments(plateau, deployments),
    do: Deployments.process_deployments(plateau, deployments)

  def version do
    {:ok, version} = :application.get_key(:mars_rover, :vsn)
    to_string(version)
  end
end
