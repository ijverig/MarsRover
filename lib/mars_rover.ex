defmodule MarsRover do
  alias MarsRover.{Deployments, Plateau}

  def deploy(plateau_limits, deployments)
      when tuple_size(plateau_limits) == 2
      when is_list(deployments) do
    Plateau.start_link(plateau_limits)
    Deployments.deploy_several(deployments)
  end

  def version, do: Keyword.get(Mix.Project.config(), :version)
end
