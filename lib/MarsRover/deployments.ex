defmodule MarsRover.Deployments do
  @moduledoc """
  Module for working with rover deployments.

  It takes the rovers positions and commands and process them,
  giving back a list with the final positions.
  """

  import MarsRover.Controls
  alias MarsRover.Plateau

  def deploy_several([]), do: Plateau.deployed_list()

  def deploy_several([{position, commands} | remaining]) do
    position |> deploy(commands) |> Plateau.add_deploy_result()
    deploy_several(remaining)
  end

  def deploy(position, commands), do: position |> validate_position() |> do_deploy(commands)

  defp do_deploy({:ok, position}, [command | remaining]),
    do: position |> next_position(command) |> deploy(remaining)

  defp do_deploy({:ok, position}, []), do: {:ok, position}
  defp do_deploy(error, _commands), do: error
  
  defp validate_position(position) do
    cond do
      Plateau.off_plateau?(position) -> {:error, :off_plateau}
      Plateau.in_collision?(position) -> {:error, :collision}
      true -> {:ok, position}
    end
  end

  defp next_position(position, :move), do: move(position)
  defp next_position(position, :left), do: rotate_left(position)
  defp next_position(position, :right), do: rotate_right(position)
end
