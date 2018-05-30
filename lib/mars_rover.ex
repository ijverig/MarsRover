defmodule MarsRover do
  @moduledoc """
  MarsRover is a library that solves the mars rover challenge.

  Given a plateau (grid) dimensions and deployments (initial position + commands),
  it returns the final positions.

  State is handled by the Plateau Agent It manages the plateau characteristics
  and deployed rovers.
  """

  alias MarsRover.{Deployments, Plateau}

  def deploy(plateau_limits, deployments)
      when tuple_size(plateau_limits) == 2
      when is_list(deployments) do
    Plateau.start_link(plateau_limits)
    Deployments.deploy_several(deployments)
  end

  def version, do: Keyword.get(Mix.Project.config(), :version)
end
