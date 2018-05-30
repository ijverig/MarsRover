defmodule MarsRover.Plateau do
  @moduledoc """
  Plateau manages the state of the plateau: keeps its dimensions
  and deployed rover positions.

  Also has checkings for positions outside the plateau and collisions against
  already deployed rovers.
  """

  use Agent

  defstruct limits: {0, 0}, deployed: []

  def start_link(limits),
    do: Agent.start_link(fn -> %__MODULE__{limits: limits} end, name: :plateau)

  def max_x, do: Agent.get(:plateau, fn %__MODULE__{limits: {x, _y}} -> x end)

  def max_y, do: Agent.get(:plateau, fn %__MODULE__{limits: {_x, y}} -> y end)

  def deployed_list, do: Agent.get(:plateau, fn plateau -> Enum.reverse(plateau.deployed) end)

  def add_deploy_result(result) do
    Agent.update(:plateau, fn plateau ->
      Map.update!(plateau, :deployed, fn deployed -> [result | deployed] end)
    end)
  end

  def off_plateau?({x, y, _heading}) do
    x not in 0..max_x() or y not in 0..max_y()
  end

  def in_collision?({x, y, _heading}) do
    Enum.any?(deployed_list(), fn
      {:ok, {x2, y2, _heading}} -> {x, y} == {x2, y2}
      _error -> false
    end)
  end
end
